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
    private let supabase: SupabaseClient

    init(globalStudentState: GlobalStudentDataState, supabase: SupabaseClient) {
        self.globalStudentState = globalStudentState
        self.supabase = supabase
    }

    /// Handles query changes with debounce
    func updateQuery(_ newValue: String) {
        query = newValue
        debounceTask?.cancel() // Cancel previous task if running

        debounceTask = Task { @MainActor in
            try? await Task.sleep(nanoseconds: 300_000_000) // 300ms debounce
            await fetchSuggestions(for: query)
        }
    }

    /// Fetches suggestions based on the query
    func fetchSuggestions(for query: String) async {
        guard !query.isEmpty else {
            suggestions = []
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let formattedQuery = query.replacingOccurrences(of: " ", with: "+")
            let fetchedSuggestions: [School] = try await supabase.rpc(
                "search_schools",
                params: ["prefix": formattedQuery]
            ).execute().value

            await MainActor.run {
                self.suggestions = fetchedSuggestions
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }

        await MainActor.run {
            self.isLoading = false
        }
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
