//
//  SearchSheet.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct SearchSheet: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: SearchSheetViewModel
    @State private var showSchool: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Search Bar
            TextField("Search schools...", text: $viewModel.query)
                .onChange(of: viewModel.query) { newValue in
                    viewModel.debounceSearch(query: newValue)
                }
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SurfaceContainer"))
                        .stroke(Color("Border"), lineWidth: 1)
                )
                .padding(.horizontal, 16)
                .padding(.top, 32)

            // Suggestions or Loading/Error state
            if viewModel.isLoading {
                ProgressView()
                    .padding(.horizontal, 16)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                    .foregroundColor(.red)
                    .padding(.horizontal, 16)
            } else if !viewModel.suggestions.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.suggestions.prefix(10), id: \.id) { school in
                            Button(action: {
                                Task {
                                    await viewModel.fetchMatch(for: school)
                                    viewModel.selectedSchool = school
                                    showSchool = true
                                }
                            }) {
                                Text(school.name)
                                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                                    .multilineTextAlignment(.leading)
                                    .padding(.vertical, 8)
                                    .lineSpacing(4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color("OnSurface"))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 16)
                        }
                    }
                }
            } else if !viewModel.query.isEmpty {
                Text("No results found")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 16)
            }

            Spacer()
        }
        .padding(.bottom, 16)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .background(Color("Surface"))
        .sheet(isPresented: $showSchool) {
            if let school = viewModel.selectedSchool,
               let matchScore = viewModel.studentMatchScore {
                CollegeInfoView(
                    school: school,
                    studentMatchScore: matchScore
                )
                .presentationDetents([.fraction(1)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}
