//
//  ExploreCard.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//

import SwiftUI
import MapKit

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
                    HStack(spacing: 8) {
                        TagView(text: "Average ACT: \(model.school.act)", backgroundColor: Color.yellow)
                        TagView(text: "Public or Private?", backgroundColor: Color.green)
                    }
                    .padding(.top, 12)

                    HStack(spacing: 8) {
                        TagView(text: "Avg Aid: \(model.school.averageFinancialAid)", backgroundColor: Color.green)
                        TagView(text: "Avg Tuition: \(model.school.inStateTuition)", backgroundColor: Color.green)
                        TagView(text: "Student Size: \(model.school.size)", backgroundColor: Color.red)
                    }

                    // Main College Info
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(model.school.name)
                                .font(Font.custom("Plus Jakarta Sans Bold", size: 24))
                                .foregroundColor(Color.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("\(model.school.city), \(model.school.state)")
                                .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                                .foregroundColor(Color.white)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text("A+")
                            .font(Font.custom("Plus Jakarta Sans Bold", size: 32))
                            .foregroundColor(Color(red: 2 / 255, green: 255 / 255, blue: 127 / 255))
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
                    BlurView(style: .regular, overlayColor: Color(red: 83 / 255, green: 83 / 255, blue: 83 / 255, opacity: 0.5)
                    ))
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .frame(width: 361, height: 616)
        .cornerRadius(20)
        .onAppear {
            // Initialize the mapRegion dynamically
            if let lat = model.school.latitude, let lon = model.school.longitude {
                mapRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: Double(lat), longitude: Double(lon)),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
    }
}

struct TagView: View {
    let text: String
    let backgroundColor: Color

    var body: some View {
        Text(text)
            .font(Font.custom("Plus Jakarta Sans Medium", size: 12))
            .foregroundColor(Color.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(backgroundColor)
            .cornerRadius(8)
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
