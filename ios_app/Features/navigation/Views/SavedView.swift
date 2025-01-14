//
//  SavedView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//

import SwiftUI

struct SavedView: View {
    @EnvironmentObject var globalStudentState: GlobalStudentDataState
    @StateObject private var viewModel: SavedViewModel
    
    init() {
        // Create the VM. We'll inject the environment object *after* init
        _viewModel = StateObject(
            wrappedValue: SavedViewModel(globalStudentState: GlobalStudentDataState())
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Header row
            HStack {
                VStack(alignment: .leading) {
                    Text("Liked Colleges")
                        .font(.title)
                    Text("\(viewModel.likedSchools.count) Liked Colleges")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                // Sort button or any other top-right action
                Button(action: {
                    // Provide sorting logic if desired
                }) {
                    HStack {
                        Text("Sort List")
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)

            // Content area
            if viewModel.isLoading {
                ProgressView("Loading liked schools...")
                    .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.likedSchools.isEmpty {
                Text("No liked schools yet.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Scrollable list of SavedCardViews
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.likedSchools) { school in
                            SavedCardView(school: school, rating: "A+")
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
        }
        .padding(.top, 16)
        .onAppear {
            Task {
                await viewModel.fetchLikedSchools()
            }
        }
    }
}

#Preview {
    // Provide a mock environment object for preview:
    SavedView()
        .environmentObject(GlobalStudentDataState())
}
