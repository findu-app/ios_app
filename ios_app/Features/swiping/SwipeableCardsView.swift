import SwiftUI

struct SwipeableCardsView: View {
    @EnvironmentObject var globalStudentState: GlobalStudentDataState
    @StateObject private var viewModel: CardsViewModel

    @State private var dragState = CGSize.zero
    @State private var cardRotation: Double = 0

    private let swipeThreshold: CGFloat = 100.0
    private let rotationFactor: Double = 35.0

    init() {
        // Initialize the viewModel with the global state
        let globalState = GlobalStudentDataState()
        _viewModel = StateObject(wrappedValue: CardsViewModel(globalStudentState: globalState))
    }

    var body: some View {
        VStack {
            if viewModel.schools.isEmpty && viewModel.isLoading {
                ProgressView("Loading...")
            } else if viewModel.schools.isEmpty {
                Text("No Schools Left")
                    .font(.headline)
                    .padding()
            } else {
                ZStack {
                    ForEach(viewModel.schools.reversed()) { school in
                        CardView(
                            school: school,
                            matchScore: viewModel.matchScore(for: school),
                            onSwipe: { direction in
                                flingOffScreen(direction)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    Task {
                                        await viewModel.handleSwipe(direction: direction)
                                    }
                                    resetDrag()
                                }
                            },
                            onReverse: {
                                withAnimation {
                                    viewModel.undoSwipe()
                                }
                            }
                        )
                        .offset(x: viewModel.isTopSchool(school) ? dragState.width : 0)
                        .rotationEffect(.degrees(viewModel.isTopSchool(school) ? cardRotation : 0))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if viewModel.isTopSchool(school) {
                                        dragState = gesture.translation
                                        cardRotation = Double(dragState.width) / rotationFactor
                                    }
                                }
                                .onEnded { _ in
                                    if viewModel.isTopSchool(school), abs(dragState.width) > swipeThreshold {
                                        let direction: CardSwipeDirection =
                                            (dragState.width > 0) ? .right : .left
                                        flingOffScreen(direction)
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            Task {
                                                await viewModel.handleSwipe(direction: direction)
                                            }
                                            resetDrag()
                                        }
                                    } else {
                                        withAnimation(.spring()) {
                                            resetDrag()
                                        }
                                    }
                                }
                        )
                    }
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                await viewModel.loadInitialSchools()
            }
        }
    }

    private func flingOffScreen(_ direction: CardSwipeDirection) {
        withAnimation(.easeOut(duration: 0.5)) {
            dragState.width = (direction == .right) ? 1000 : -1000
        }
    }

    private func resetDrag() {
        dragState = .zero
        cardRotation = 0
    }
}
