//
//  ExploreView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//

import SwiftUI

struct ExploreView: View {
    @State private var schools: [School] = []  // Stores fetched schools
    @State private var isLoading = false      // Indicates if data is being fetched
    @State private var errorMessage: String?  // Stores any error messages

    private func fetchSchools() {
        isLoading = true
        errorMessage = nil
        schools = []

        CollegeAPI.shared.fetchSchools(query: "Nebraska") { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedSchools):
                    self.schools = fetchedSchools
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading schools...")  // Show loading indicator
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                // Initialize SwipeableCards with fetched schools
                let model = SwipeableCards.Model(
                    cards: schools.map { school in
                        // Create a card model for each school
                        ExploreCard.Model(
                            school: school
                        )
                    }
                )

                SwipeableCards(model: model) { model in
                    print(model.swipedCards)
                    model.reset()  // Reset the cards after swipe
                }
            }
        }
        .onAppear {
            fetchSchools()  // Fetch schools when view appears
        }
        .background(Color("Surface"))
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
