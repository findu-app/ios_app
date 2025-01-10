//
//  ExploreView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()

    var body: some View {
        VStack {
            if viewModel.isLoading && viewModel.schools.isEmpty {
                ProgressView("Loading schools...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                let model = SwipeableCards.Model(
                    cards: viewModel.schools.map { school in
                        ExploreCard.Model(school: school)
                    }
                )

                SwipeableCards(
                    model: model,
                    loadMoreCards: {
                        Task {
                            await viewModel.loadMoreSchools()
                        }
                    }
                )
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchInitialSchools()
            }
        }
        .background(Color("Surface"))
    }
}
