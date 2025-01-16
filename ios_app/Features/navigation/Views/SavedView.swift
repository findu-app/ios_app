import SwiftUI

struct SavedView: View {
    @EnvironmentObject var globalStudentState: GlobalStudentDataState
    @StateObject private var viewModel: SavedViewModel
    
    init() {
        _viewModel = StateObject(
            wrappedValue: SavedViewModel(globalStudentState: GlobalStudentDataState())
        )
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                // Header row
                HStack(alignment: .firstTextBaseline) {
                    VStack(alignment: .leading) {
                        Text("Liked Colleges")
                            .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                            .padding(.bottom, 4)
                        Text("\(viewModel.likedSchools.count) Liked Colleges")
                            .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                            .foregroundColor(Color("Secondary"))
                    }
                    Spacer()

                    SortMenu { field, ascending in
                        viewModel.sortLikedSchools(by: field, ascending: ascending)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)

                // Content area
                if viewModel.isLoading {
                    ProgressView("Loading liked schools...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(Color("Primary"))
                        .padding()
                } else if viewModel.likedSchools.isEmpty {
                    Text("No liked schools yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    VStack(spacing: 16) {
                        ForEach(viewModel.likedSchools) { school in
                            SavedCardView(school: school, globalStudentState: globalStudentState)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 16)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchLikedSchools()
            }
        }
    }
}

#Preview {
    SavedView()
        .environmentObject(GlobalStudentDataState())
}
