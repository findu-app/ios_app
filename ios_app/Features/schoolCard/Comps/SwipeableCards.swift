import SwiftUI

struct SwipeableCards: View {
    class Model: ObservableObject {
        @Published var cards: [ExploreCard.Model]
        @Published var swipedCards: [ExploreCard.Model]

        init(cards: [ExploreCard.Model]) {
            self.cards = cards
            self.swipedCards = []
        }

        func removeTopCard() {
            if !cards.isEmpty {
                guard let card = cards.first else { return }
                cards.removeFirst()
                swipedCards.append(card)
            }
        }

        func updateTopCardSwipeDirection(_ direction: ExploreCard.SwipeDirection) {
            if !cards.isEmpty {
                cards[0].swipeDirection = direction
            }
        }

        func appendCards(newCards: [ExploreCard.Model]) {
            cards.append(contentsOf: newCards)
        }
    }

    @ObservedObject var model: Model
    @State private var dragState = CGSize.zero
    @State private var cardRotation: Double = 0

    private let swipeThreshold: CGFloat = 100.0
    private let rotationFactor: Double = 35.0

    var loadMoreCards: () -> Void

    var body: some View {
        GeometryReader { geometry in
            if model.cards.isEmpty && model.swipedCards.isEmpty {
                emptyCardsView
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else if model.cards.isEmpty {
                swipingCompletionView
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                ZStack {
                    ForEach(model.cards.reversed()) { card in
                        let isTop = card == model.cards.first
                        let isSecond = card == model.cards.dropFirst().first

                        ExploreCard(
                            model: card,
                            dragOffset: isTop ? dragState : .zero,
                            isTopCard: isTop,
                            isSecondCard: isSecond,
                            onSwipe: { direction in
                                handleSwipe(direction: direction)
                            }
                        )
                        .offset(x: isTop ? dragState.width : 0)
                        .rotationEffect(.degrees(isTop ? Double(dragState.width) / rotationFactor : 0))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.7) // Adjust card size
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height / 2 // Center card in view
                        )
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if isTop {
                                        dragState = gesture.translation
                                        cardRotation = Double(gesture.translation.width) / rotationFactor
                                    }
                                }
                                .onEnded { _ in
                                    if isTop && abs(dragState.width) > swipeThreshold {
                                        let swipeDirection: ExploreCard.SwipeDirection = dragState.width > 0 ? .right : .left
                                        handleSwipe(direction: swipeDirection)
                                    } else {
                                        withAnimation(.spring()) {
                                            dragState = .zero
                                            cardRotation = 0
                                        }
                                    }
                                }
                        )
                        .animation(.easeInOut, value: dragState)
                    }
                }
            }
        }
    }

    private func handleSwipe(direction: ExploreCard.SwipeDirection) {
        guard !model.cards.isEmpty else { return }
        model.updateTopCardSwipeDirection(direction)

        withAnimation(.easeOut(duration: 0.5)) {
            dragState.width = direction == .right ? 1000 : -1000
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            model.removeTopCard()
            dragState = .zero
            if model.cards.count == 5 {
                loadMoreCards()
            }
        }
    }

    var emptyCardsView: some View {
        VStack {
            Text("No Cards")
                .font(.title)
                .padding(.bottom, 20)
                .foregroundStyle(.gray)
        }
    }

    var swipingCompletionView: some View {
        VStack {
            Text("Finished Swiping")
                .font(.title)
                .padding(.bottom, 20)

            Button(action: {
                loadMoreCards()
            }) {
                Text("Load More")
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}
