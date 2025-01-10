import SwiftUI
import MapKit

struct CardView: View {
    let school: School
    let matchScore: String // In CardView
    /// Provide a closure so external views can handle the swipe.
    let onSwipe: (CardSwipeDirection) -> Void
    let onReverse: () -> Void  // <-- New closure for undo
    
    @State private var mapRegion: MKCoordinateRegion?
    @State private var isLoadingMap = true

    var body: some View {
        ZStack {
            // Map or placeholder
            if let latitude = school.latitude, let longitude = school.longitude {
                Map(coordinateRegion: .constant(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)),
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                ))
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
                    // Additional stats or tags
                    StatTagList(tags: [
                        [
                            "label": "Average ACT",
                            "stat": school.actScore != nil ? "\(school.actScore!)" : "N/A",
                            "match": "High",
                        ],
                        [
                            "label": "Avg Aid",
                            "stat": school.averageFinancialAid != nil ? "\(school.averageFinancialAid!)" : "N/A",
                            "match": "Low",
                        ],
                        [
                            "label": "Avg Tuition",
                            "stat": school.inStateTuition != nil ? "\(school.inStateTuition!)" : "N/A",
                            "match": "High",
                        ]
                    ])

                    // Main College Info
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(school.name ?? "Unknown School")
                                .font(Font.custom("Plus Jakarta Sans Bold", size: 24))
                                .foregroundColor(.white)

                            Text("\(school.city ?? "Unknown City"), \(school.state ?? "Unknown State")")
                                .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text("\(matchScore)")
                            .font(Font.custom("Plus Jakarta Sans Bold", size: 32))
                            .foregroundColor(.green)
                            .frame(alignment: .trailing)
                    }

                    // Action Buttons: Call the closure on swipe
                    ActionButtons(
                        onDislike: { onSwipe(.left) },
                        onReverse: onReverse,
                        onLike: { onSwipe(.right) }
                    )
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
                        // Blur & color overlay
                        BlurView(style: .systemMaterialDark)
                            .cornerRadius(20)
                        Color.black.opacity(0.4)
                            .cornerRadius(20)
                    }
                )
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .cornerRadius(20)
        .clipped()
        .onAppear {
            // Setup map region if coords exist
            if let lat = school.latitude, let lon = school.longitude {
                mapRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon)),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    var overlayColor: Color?

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return blurView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.subviews.forEach { $0.removeFromSuperview() }

        if let overlayColor = overlayColor {
            let overlayView = UIView(frame: uiView.bounds)
            overlayView.backgroundColor = UIColor(overlayColor)
            overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            uiView.contentView.addSubview(overlayView)
        }
    }
}
