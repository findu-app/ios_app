//
//  ExploreViewModel.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/9/25.
//


import Supabase
import Foundation

@MainActor
class ExploreViewModel: ObservableObject {
    @Published var schools: [School] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let loadBatchSize = 10 // Number of schools to load each time
    private let prefetchThreshold = 10 // Trigger loading when remaining cards are below this threshold

    func fetchInitialSchools() async {
        // Reset the state and fetch the first batch
        schools.removeAll()
        await loadMoreSchools()
    }

    func loadMoreSchools() async {
        guard !isLoading else { return }
        print("loadoing more scools")
        isLoading = true
        errorMessage = nil

        do {
            let newSchools: [School] = try await supabase
                .rpc("get_random_schools", params: ["count": loadBatchSize])
                .execute()
                .value

            DispatchQueue.main.async {
                self.schools.append(contentsOf: newSchools)
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
