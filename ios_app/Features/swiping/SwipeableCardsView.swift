import SwiftUI

struct SwipeableCardsView: View {
    let studentId: UUID // Accept the studentId as a parameter

    @StateObject private var viewModel: CardsViewModel
    @State private var dragState = CGSize.zero
    @State private var cardRotation: Double = 0

    private let swipeThreshold: CGFloat = 100.0 // Adjust threshold for swipe
    private let rotationFactor: Double = 35.0

    init(studentId: UUID) {
        self.studentId = studentId
        _viewModel = StateObject(wrappedValue: CardsViewModel(studentId: studentId)) // Initialize with studentId
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
                                // Undo logic
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

    // MARK: - Private Methods

    /// Animate card off screen
    private func flingOffScreen(_ direction: CardSwipeDirection) {
        withAnimation(.easeOut(duration: 0.5)) {
            dragState.width = (direction == .right) ? 1000 : -1000
        }
    }

    /// Reset drag to center
    private func resetDrag() {
        dragState = .zero
        cardRotation = 0
    }
}
