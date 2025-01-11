import MapKit
import SwiftUI

struct CardView: View {
    @StateObject private var viewModel: CardViewModel
    @State private var isDragging = false  // Tracks swipe activity
    let matchScore: String
    let onSwipe: (CardSwipeDirection) -> Void
    let onReverse: () -> Void
    let onOpenInfo: (School) -> Void  // Closure to open college info
    let studentMatch: StudentSchoolMatch  // Add this property

    init(
        school: School,
        matchScore: String,
        onSwipe: @escaping (CardSwipeDirection) -> Void,
        onReverse: @escaping () -> Void,
        onOpenInfo: @escaping (School) -> Void,
        studentMatch: StudentSchoolMatch
    ) {
        _viewModel = StateObject(wrappedValue: CardViewModel(school: school, studentMatch: studentMatch))
        self.matchScore = matchScore
        self.onSwipe = onSwipe
        self.onReverse = onReverse
        self.onOpenInfo = onOpenInfo
        self.studentMatch = studentMatch
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
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                            VStack {
                                Text("\(matchScore)")
                                    .font(
                                        Font.custom(
                                            "Plus Jakarta Sans Bold", size: 30)
                                    )
                                    .foregroundColor(Color("OnLike"))
                                Text("Match")
                                    .font(
                                        Font.custom(
                                            "Plus Jakarta Sans SemiBold",
                                            size: 12)
                                    )
                                    .foregroundColor(Color("OnLike"))
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

                    // Info Button
                    Button(action: {
                        onOpenInfo(viewModel.school)  // Trigger the info action
                    }) {
                        Text("View Info")
                            .font(
                                Font.custom(
                                    "Plus Jakarta Sans SemiBold", size: 14)
                            )
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black.opacity(0.25))
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 100)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        Color.black.opacity(0.3)
                            .blur(radius: 10)
                            .cornerRadius(8)
                            .background(
                                BlurView(blurRadius: 7.5)
                            )
                    }
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white.opacity(0.1), lineWidth: 2)
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 16)

            }
        }
        .cornerRadius(20)
        .clipped()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("Border"), lineWidth: 2)
        )
    }
}
