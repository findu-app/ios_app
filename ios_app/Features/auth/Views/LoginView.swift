//
//  LoginView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/26/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Spacer()
            
            Text("Welcome to")
                .font(Font.custom("Plus Jakarta Sans Light" ,  size: 32.0))
                .foregroundColor(Color("secondary"))
            
            Image(colorScheme == .dark ? "finduLogoFull_dark" : "finduLogoFull_light")
            
            Spacer()

            VStack(spacing: 16) {
                AppleButton {
                    print("Apple button tapped")
                }

                GoogleButton {
                    print("Google button tapped")
                }

                EmailButton {
                    print("Email button tapped")
                }
            }
            .padding(.horizontal, 16)

            Spacer()
                .frame(height: 48)
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    LoginView()
}
