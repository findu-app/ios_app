//
//  SearchSheetViewModel.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/17/25.
//


import SwiftUI
import Combine

class SearchSheetViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var suggestions: [School] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var selectedSchool: School? = nil
    @Published var studentMatchScore: StudentSchoolMatch? = nil
    
    private var debounceTask: Task<Void, Never>? = nil
    private let globalStudentState: GlobalStudentDataState

    init(globalStudentState: GlobalStudentDataState) {
        self.globalStudentState = globalStudentState
    }

        /// Debounces the search to avoid too many API calls
        func debounceSearch(query: String) {
            debounceTask?.cancel() // Cancel the previous task if it's still running

            debounceTask = Task { @MainActor in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 300ms delay
                    Task { @MainActor in
                        await self.fetchSuggestions(for: query)
                    }
                }
            }
        }

        /// Fetches suggestions based on the search query
        private func fetchSuggestions(for query: String) async {
            guard !query.isEmpty else {
                suggestions = []
                return
            }

            isLoading = true
            errorMessage = nil

            do {
                // Replace spaces with `+` for the tsquery format
                let formattedQuery = query.replacingOccurrences(of: " ", with: "+")

                let fetchedSuggestions: [School] = try await supabase.rpc(
                    "search_schools",
                    params: ["prefix": formattedQuery]
                ).execute().value

                suggestions = fetchedSuggestions
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }

    
    /// Fetches and calculates the match score between the student and a school
    func fetchMatch(for school: School) async {
        guard let studentProfile = globalStudentState.studentInfo else {
            print("No student profile available.")
            return
        }

        let computedMatch = MatchScoreCalculator.computeMatchScore(
            for: school,
            student: studentProfile
        )

        await MainActor.run {
            self.studentMatchScore = computedMatch
        }
    }
}
