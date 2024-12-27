//
//  SplashView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/26/24.
//

import SwiftUI

struct SplashView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Color("Surface")
                           .ignoresSafeArea()
            
            Image(colorScheme == .dark ? "finduLogoFull_dark" : "finduLogoFull_light")
        }
    }
}

#Preview {
    SplashView()
}
