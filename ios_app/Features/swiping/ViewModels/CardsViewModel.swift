//
//  CardViewModel.swift
//  ios_app
//
//  Created by Kenny Morales on 1/10/25.
//

import SwiftUI

@MainActor
class CardsViewModel: ObservableObject {
    @Published var schools: [School] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // Access to the globalStudentState for the matching
    private var globalStudentState: GlobalStudentDataState
    // Swiped history to operate an undo
    private var swipedHistory: [School] = []

    private var localMatchScores: [StudentSchoolKey: StudentSchoolMatch] = [:]
    // Manages the schoolID's to avoid duplicates and limiters for the fetching.
    private var swipedSchoolIDs: Set<UUID> = []
    private let preloadThreshold = 5
    private let loadBatchSize = 5

    init(globalStudentState: GlobalStudentDataState) {
        self.globalStudentState = globalStudentState
    }

    /// Loads the initial batch of schools
    func loadInitialSchools() async {
        await loadMoreSchools()
    }

    /// Loads schools from Supabase
    /// 1. Fetches schools from supabase at the desiredBatchSize
    /// 2. Filters out the already swiped schools
    /// 3. Access the stduent profile and then matches
    func loadMoreSchools() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil

        do {
            // Fetch schools from Supabase
            let newSchools: [School] =
                try await supabase
                .rpc("get_random_schools", params: ["count": loadBatchSize])
                .execute()
                .value

            // Filter out already swiped schools
            let filtered = newSchools.filter {
                !swipedSchoolIDs.contains($0.id)
            }

            // Access the student profile
            guard let studentProfile = globalStudentState.studentInfo else {
                print("No student profile available")
                return
            }

            // Compute match scores for the active student
            for school in filtered {
                let key = StudentSchoolKey(
                    studentId: UUID(uuidString: studentProfile.id) ?? UUID(),
                    schoolId: school.id
                )
                
                // Compute the full match object
                let match = MatchScoreCalculator.computeMatchScore(for: school, student: studentProfile)
                
                // Cache the match score as a string
                localMatchScores[key] = match
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

    func matchForSchool(_ school: School) -> StudentSchoolMatch {
        // Ensure the student profile is available
        guard let studentProfile = globalStudentState.studentInfo else {
            fatalError("No student profile available")
        }

        // Construct the unique key for the student and school
        let key = StudentSchoolKey(
            studentId: UUID(uuidString: studentProfile.id) ?? UUID(),
            schoolId: school.id
        )

        // Fetch the match score from the local cache or compute if missing
        if let cachedMatch = localMatchScores[key] {
            return cachedMatch
        } else {
            let computedMatch = MatchScoreCalculator.computeMatchScore(
                for: school,
                student: studentProfile
            )
            localMatchScores[key] = computedMatch  // Cache the computed match
            return computedMatch
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