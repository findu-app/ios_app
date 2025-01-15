//
//  SavedCardView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/13/25.
//


import SwiftUI

struct SavedCardView: View {
    @StateObject private var viewModel: SavedCardViewModel

    init(school: School, globalStudentState: GlobalStudentDataState) {
        _viewModel = StateObject(wrappedValue: SavedCardViewModel(school: school, globalStudentState: globalStudentState))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // School Title & Rating
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.school.name ?? "Unknown School")
                        .font(Font.custom("Plus Jakarta Sans SemiBold", size: 18))
                        .foregroundColor(Color("OnSurface"))
                        .lineLimit(2)

                    Text("\(viewModel.school.city ?? ""), \(viewModel.school.state ?? "")")
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 14))
                        .foregroundColor(Color("Secondary"))
                }
                Spacer()
                Text(viewModel.matchScore)
                    .font(Font.custom("Plus Jakarta Sans Bold", size: 24))
                    .foregroundColor(StatFormatter.colorForMatchScoreCard(viewModel.matchScore))
            }

            // Tags, rendered by StatTagList
            StatTagList(tags: viewModel.tags)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("SurfaceContainer"))
                .stroke(Color("Border"), lineWidth: 1)
        )
        .onTapGesture {
            // Show the sheet when the card is tapped
            viewModel.showSheet = true
        }
        .sheet(isPresented: $viewModel.showSheet) {
            // Pass the school and match data to the sheet
            if let studentMatch = viewModel.studentMatch {CollegeInfoView(
                school: viewModel.school,
                studentMatchScore: studentMatch
            )
            .presentationDetents([.fraction(1)]) // Fullscreen height
            .presentationDragIndicator(.visible) // Drag indicator
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMatchScore()

                viewModel.buildTags()
            }
        }
    }
}
