import SwiftUI
import Supabase

@MainActor
class CardsViewModel: ObservableObject {
    // The main list of schools for the UI
    @Published var schools: [School] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // If you support multiple students at once, store them in some structure.
    // For now, let's assume a single active student:
    var currentStudentId: UUID
    var studentProfile: StudentInfo?
    
    private var swipedHistory: [School] = []


    // We keep our match scores here, in memory
    private var localMatchScores: [StudentSchoolKey: String] = [:]

    // If you still need to track swipes:
    private var swipedSchoolIDs: Set<UUID> = []
    private let preloadThreshold = 5
    private let loadBatchSize = 10

    init(studentId: UUID) {
        self.currentStudentId = studentId
    }

    func loadInitialSchools() async {
        await loadMoreSchools()
    }

    func loadMoreSchools() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            // 1) Fetch some schools from Supabase, for example
            let newSchools: [School] = try await supabase
                .rpc("get_random_schools", params: ["count": loadBatchSize])
                .execute()
                .value

            // 2) Filter out any that have been swiped
            let filtered = newSchools.filter { !swipedSchoolIDs.contains($0.id) }

            // 3) Compute & store match scores for the active student
            for school in filtered {
                let key = StudentSchoolKey(studentId: currentStudentId, schoolId: school.id)
                localMatchScores[key] = computeMatchScore(for: school, student: studentProfile)
            }

            // 4) Append them for display
            self.schools.append(contentsOf: filtered)

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    /// Example: remove the top school when swiped
    func handleSwipe(direction: CardSwipeDirection) async {
        guard let topSchool = schools.first else { return }
        schools.removeFirst()
        swipedSchoolIDs.insert(topSchool.id)

        if schools.count < preloadThreshold {
            await loadMoreSchools()
        }
    }

    // MARK: - Compute the Match Score

    private func computeMatchScore(for school: School, student: StudentInfo?) -> String {
        guard let student = student,
              let sACT = school.actScore,
              let stACT = student.actScore else {
            print("Missing ACT scores. Returning grade C for school: \(school.name ?? "Unknown")")
            return "C" // Default to "C" if data is missing
        }

        // Calculate the absolute difference
        let diff = abs(Double(stACT) - Double(sACT))

        // Map the difference to a grade with higher ranges
        let grade: String
        switch diff {
        case 0...5:
            grade = "A" // Excellent match
        case 6...10:
            grade = "B" // Good match
        default:
            grade = "C" // Below average match
        }

        // Debug output
        print("Student ACT: \(stACT), School ACT: \(sACT), Difference: \(diff), Grade: \(grade) for school: \(school.name ?? "Unknown")")

        return grade
    }



    // MARK: - Accessing the Score from the UI

    /// A helper for your SwiftUI views
    func matchScore(for school: School) -> String {
        let key = StudentSchoolKey(studentId: currentStudentId, schoolId: school.id)
        return localMatchScores[key] ?? "C" // Default to "C"
    }

    func isTopSchool(_ school: School) -> Bool {
        return school.id == schools.first?.id
    }

    /// Undo the last swipe
    func undoSwipe() {
        // 3) Pop the last-swiped school (if any)
        guard let lastSwiped = swipedHistory.popLast() else { return }
        // Remove it from swipedSchoolIDs so we can swipe it again
        swipedSchoolIDs.remove(lastSwiped.id)
        // Put it back on top of the schools array
        schools.insert(lastSwiped, at: 0)

        print("Undo swipe for: \(lastSwiped.name)")
    }
}
