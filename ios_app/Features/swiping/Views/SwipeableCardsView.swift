import SwiftUI

struct SwipeableCardsView: View {
    @EnvironmentObject var globalStudentState: GlobalStudentDataState
    @StateObject private var viewModel: CardsViewModel

    @State private var dragState = CGSize.zero
    @State private var cardRotation: Double = 0
    @State private var showInfo = false // Tracks if the sheet is visible
    @State private var selectedSchool: School? // Tracks the selected school

    private let swipeThreshold: CGFloat = 100.0
    private let minimumDragDistance: CGFloat = 35.0 // Threshold for a small drag
    private let rotationFactor: Double = 10.0
    private let maxVisibleCards = 2 // Limit the number of visible cards

    init() {
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
                    ForEach(viewModel.schools.prefix(maxVisibleCards).reversed()) { school in
                        let studentMatch = viewModel.matchForSchool(school)
                        
                        CardView(
                            school: school,
                            matchScore: studentMatch.matchScore, // Use the computed match score
                            onSwipe: { direction in
                                handleSwipeAction(direction: direction)
                            },
                            onReverse: {
                                withAnimation {
                                    viewModel.undoSwipe()
                                }
                            },
                            onOpenInfo: { selectedSchool in
                                self.selectedSchool = selectedSchool
                                showInfo = true
                            },
                            studentMatch: studentMatch
                        )
                        .offset(x: viewModel.isTopSchool(school) ? dragState.width : 0)
                        .rotationEffect(.degrees(viewModel.isTopSchool(school) ? cardRotation : 0))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if viewModel.isTopSchool(school) {
                                        let dragDistance = gesture.translation
                                        if abs(dragDistance.width) > minimumDragDistance || abs(dragDistance.height) > minimumDragDistance {
                                            dragState = dragDistance
                                            cardRotation = Double(dragDistance.width) / rotationFactor
                                        }
                                    }
                                }
                                .onEnded { gesture in
                                    if viewModel.isTopSchool(school) {
                                        let dragDistance = gesture.translation
                                        if dragDistance.height < -swipeThreshold {
                                            selectedSchool = school
                                            showInfo = true
                                            resetDrag()
                                        } else if abs(dragDistance.width) > swipeThreshold {
                                            let direction: CardSwipeDirection = (dragDistance.width > 0) ? .right : .left
                                            handleSwipeAction(direction: direction)
                                        } else {
                                            withAnimation(.spring()) {
                                                resetDrag()
                                            }
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
        .sheet(item: $selectedSchool, onDismiss: {
            resetDrag() // Reset drag when the sheet is dismissed
        }) { school in
            let studentMatch = viewModel.matchForSchool(school)
            CollegeInfoView(school: school, studentMatchScore: studentMatch)
                .presentationDetents([.fraction(1)]) // Allow resizing between medium and large
                .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $viewModel.showSheet, onDismiss: {
            resetDrag()
        }) {
            CollegeInfoForm(
                studentSchoolInteraction: $viewModel.currentInteraction,
                onSubmit: { updatedInteraction in
                    // Handle submission here
                    Task {
                        do {
                            try await viewModel.insertInteraction(updatedInteraction)
                            viewModel.showSheet = false // Close the sheet
                        } catch {
                            print("Failed to save interaction: \(error.localizedDescription)")
                        }
                    }
                }
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
            .interactiveDismissDisabled() // Prevent dismissal unless explicitly handled
        }
    }

    private func handleSwipeAction(direction: CardSwipeDirection) {
        withAnimation(.spring(duration: 0.5)) {
            dragState.width = (direction == .right) ? 750 : -750
            cardRotation = (direction == .right) ? rotationFactor : -rotationFactor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Task {
                await viewModel.handleSwipe(direction: direction)
            }
            resetDrag()
        }
    }

    private func resetDrag() {
        dragState = .zero
        cardRotation = 0
    }
}
