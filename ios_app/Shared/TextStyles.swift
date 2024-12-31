//
//  TextStyles.swift
//  ios_app
//
//  Created by Kenny Morales on 12/29/24.
//

import SwiftUI

// MARK: - ViewModifier for Centered Title Text
struct CenteredTitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
            .foregroundColor(Color("OnSurface"))
            .multilineTextAlignment(.center)
    }
}

// MARK: - Extension for Easy Application
extension View {
    func centeredTitleTextStyle() -> some View {
        self.modifier(CenteredTitleTextStyle())
    }
}


