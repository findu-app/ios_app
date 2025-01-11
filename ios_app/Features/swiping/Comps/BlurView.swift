//
//  BlurView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/11/25.
//

import SwiftUI

/// A reusable BlurView component for SwiftUI
struct BlurView: UIViewRepresentable {
    var blurRadius: CGFloat

    /// Creates the underlying `UIVisualEffectView` with the specified blur style
    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = CGFloat(blurRadius / 10)
        return blurView
    }

    /// Updates the `UIVisualEffectView` if the blur style changes
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        if uiView.effect is UIBlurEffect {
            uiView.alpha = CGFloat(blurRadius / 10)
        }
    }
}
