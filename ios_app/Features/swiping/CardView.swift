import MapKit
import SwiftUI

struct CardView: View {
    @StateObject private var viewModel: CardViewModel
    let matchScore: String
    let onSwipe: (CardSwipeDirection) -> Void
    let onReverse: () -> Void

    init(
        school: School, matchScore: String,
        onSwipe: @escaping (CardSwipeDirection) -> Void,
        onReverse: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: CardViewModel(school: school))
        self.matchScore = matchScore
        self.onSwipe = onSwipe
        self.onReverse = onReverse
    }

    var body: some View {
        ZStack {
            // Map or placeholder
            if let region = viewModel.mapRegion {
                Map(coordinateRegion: .constant(region))
                    .cornerRadius(20)
                    .overlay(
                        LinearGradient(
                            colors: [Color.black.opacity(0.6), Color.clear],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .cornerRadius(20)
                    )
            } else {
                Color.gray
                    .cornerRadius(20)
            }

            VStack {
                Spacer()

                // Card Info & Action Buttons
                VStack(alignment: .leading, spacing: 12) {
                    // TODO: Change to individual tags with Public/Private being at top because it is subject to change
                    StatTagList(tags: viewModel.statTags())

                    // Main College Info
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text(viewModel.schoolName())
                                .font(
                                    Font.custom(
                                        "Plus Jakarta Sans Bold", size: 24)
                                )
                                .foregroundColor(Color("AllWhite"))
                                .lineLimit(2)  // Allow up to 2 lines
                                .multilineTextAlignment(.leading)  // Align text to the left
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            VStack {
                                Text("\(matchScore)")
                                    .font(
                                        Font.custom(
                                            "Plus Jakarta Sans Bold", size: 30)
                                    )
                                    .foregroundColor(Color("OnLike"))//TODO: Update this
                                Text("Match")
                                    .font(
                                        Font.custom(
                                            "Plus Jakarta Sans SemiBold",
                                            size: 12)
                                    )
                                    .foregroundColor(Color("OnLike"))//TODO: Update this
                            }
                        }
                        Text(viewModel.formattedLocation())
                            .font(
                                Font.custom(
                                    "Plus Jakarta Sans Medium", size: 16)
                            )
                            .foregroundColor(.white)

                    }

                    // Action Buttons: Call the closure on swipe
                    ActionButtons(
                        onDislike: { onSwipe(.left) },
                        onReverse: onReverse,
                        onLike: { onSwipe(.right) }
                    )
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        Color.black.opacity(0.4)
                            .blur(radius: 10)
                            .cornerRadius(8)
                            .background(
                                BlurView(blurRadius: 7.5)
                            )
                    }
                )
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .cornerRadius(20)
        .clipped()
    }
}
