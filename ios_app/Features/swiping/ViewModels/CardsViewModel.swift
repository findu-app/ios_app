import SwiftUI

@MainActor
class CardsViewModel: ObservableObject {
    @Published var schools: [School] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var globalStudentState: GlobalStudentDataState
    private var swipedHistory: [School] = []

    private var localMatchScores: [StudentSchoolKey: String] = [:]
    private var swipedSchoolIDs: Set<UUID> = []
    private let preloadThreshold = 5
    private let loadBatchSize = 10

    init(globalStudentState: GlobalStudentDataState) {
        self.globalStudentState = globalStudentState
    }

    func loadInitialSchools() async {
        await loadMoreSchools()
    }

    func loadMoreSchools() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            // Fetch schools from Supabase
            let newSchools: [School] = try await supabase
                .rpc("get_random_schools", params: ["count": loadBatchSize])
                .execute()
                .value

            // Filter out already swiped schools
            let filtered = newSchools.filter { !swipedSchoolIDs.contains($0.id) }

            // Access the student profile
            guard let studentProfile = globalStudentState.studentInfo else {
                print("No student profile available")
                return
            }

            // Compute match scores for the active student
            for school in filtered {
                let key = StudentSchoolKey(studentId: UUID(uuidString: studentProfile.id) ?? UUID(), schoolId: school.id)
                let score = MatchScoreCalculator.computeMatchScore(for: school, student: studentProfile)
                localMatchScores[key] = score
            }

            // Append new schools for display
            self.schools.append(contentsOf: filtered)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func handleSwipe(direction: CardSwipeDirection) async {
        guard let topSchool = schools.first else { return }
        
        // Add the swiped school to history
        swipedHistory.append(topSchool)
        
        schools.removeFirst()
        swipedSchoolIDs.insert(topSchool.id)

        if schools.count < preloadThreshold {
            await loadMoreSchools()
        }
    }


    func matchScore(for school: School) -> String {
        // Ensure the student profile is available
        guard let studentProfile = globalStudentState.studentInfo else {
            print("No student profile available. Returning default grade C.")
            return "C"
        }

        // Construct the unique key for the student and school
        let key = StudentSchoolKey(studentId: UUID(uuidString: studentProfile.id) ?? UUID(), schoolId: school.id)

        // Fetch the match score from the local cache, compute if missing
        if let cachedScore = localMatchScores[key] {
            return cachedScore
        } else {
            let score = MatchScoreCalculator.computeMatchScore(for: school, student: studentProfile)
            localMatchScores[key] = score // Cache the computed score
            return score
        }
    }

    func isTopSchool(_ school: School) -> Bool {
        return school.id == schools.first?.id
    }

    func undoSwipe() {
        guard let lastSwiped = swipedHistory.popLast() else { return }
        swipedSchoolIDs.remove(lastSwiped.id)
        schools.insert(lastSwiped, at: 0)
        print("Undo swipe for: \(lastSwiped.name)")
    }
}
