//  ExploreCard.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.

import MapKit
import SwiftUI

struct ExploreCard: View {
    enum SwipeDirection {
        case left, right, none
    }

    struct Model: Identifiable, Equatable {
        let id = UUID()
        let school: School
        var swipeDirection: SwipeDirection = .none

    }

    var model: Model
    var dragOffset: CGSize
    var isTopCard: Bool
    var isSecondCard: Bool

    @State private var mapRegion: MKCoordinateRegion?
    @State private var isLoadingMap = true

    // Fetch the map region using geocoding
    private func fetchMapRegion(for location: String) {
        LocationUtils.fetchCoordinates(for: location) { result in
            switch result {
            case .success(let coordinate):
                DispatchQueue.main.async {
                    self.mapRegion = MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(
                            latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                }
            case .failure(let error):
                print(
                    "Error fetching coordinates: \(error.localizedDescription)")
            }
        }
    }

    var body: some View {
        ZStack {
            // Background Image
            if let region = mapRegion {
                // Apple Map background
                Map(coordinateRegion: .constant(region))
                    .cornerRadius(20)
                    .overlay(
                        LinearGradient(
                            colors: [Color.black.opacity(0.6), Color.clear],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
            } else {
                // Placeholder while map is loading
                Color.gray
                    .cornerRadius(20)
            }

            // Gray blurred container
            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 12) {
                    // Tags
                    StatTagList(tags: [
                        [
                            "label": "Average ACT",
                            "stat": "\(model.school.averageSAT)",
                            "match": "High",
                        ],
                        [
                            "label": "Public or Private?", "stat": "",
                            "match": "Med",
                        ],
                        ["label": "Avg Aid:", "stat": "", "match": "Low"],
                        [
                            "label": "Avg Tuition:",
                            "stat": "\(model.school.coaAcademicYear)",
                            "match": "High",
                        ],
                        [
                            "label": "Student Size:",
                            "stat": "\(model.school.size)", "match": "High",
                        ],
                    ])
                    .padding(.top, 12)

                    // Main College Info
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(model.school.name)
                                .font(
                                    Font.custom(
                                        "Plus Jakarta Sans Bold", size: 24)
                                )
                                .foregroundColor(Color.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("\(model.school.city), \(model.school.state)")
                                .font(
                                    Font.custom(
                                        "Plus Jakarta Sans Medium", size: 16)
                                )
                                .foregroundColor(Color.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text("A+")
                            .font(
                                Font.custom("Plus Jakarta Sans Bold", size: 32)
                            )
                            .foregroundColor(
                                Color(
                                    red: 2 / 255, green: 255 / 255,
                                    blue: 127 / 255)
                            )
                            .frame(alignment: .trailing)
                    }

                    // Action Buttons
                    ActionButtons(
                        onDislike: { print("Dislike button tapped") },
                        onReverse: { print("Reverse button tapped") },
                        onLike: { print("Like button tapped") }
                    )
                    .padding(.bottom, 24)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    ZStack {
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
        .frame(width: 361, height: 616)
        .cornerRadius(20)
        .onAppear {
            fetchMapRegion(for: "\(model.school.city), \(model.school.state)")
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

struct ExploreCard_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCard(
            model: ExploreCard.Model(
                school: School(
                    id: 1, name: "University of Nebraska-Lincoln",
                    city: "Lincoln", state: "NE", size: 5000, averageSAT: 1200,
                    coaAcademicYear: 2025)
            ),
            dragOffset: .zero,
            isTopCard: true,
            isSecondCard: false
        )
        .preferredColorScheme(.dark)
    }
}
