//
//  WelcomeUserView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/29/24.
//

import SwiftUI

struct WelcomeUserView: View {
    var studentName: String

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 20) {
                Image("piece-sign-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 72)
                
                (Text("We're glad to have you with us, ")
                        .font(Font.custom("Plus Jakarta Sans Bold", size: 32))

                        + Text(firstName(from: studentName) + "!")
                        .font(Font.custom("Plus Jakarta Sans Bold", size: 32))
                        .foregroundColor(Color("Primary")))
                
                Text("Share a bit more about yourself")
                    .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                    .foregroundColor(Color("OnSurface"))
            }
            .padding(.bottom, 128)

            Spacer()
        }
    }

    /// Extracts the first name from a full name string
    private func firstName(from fullName: String) -> String {
        return fullName.split(separator: " ").first.map(String.init) ?? fullName
    }
}

#Preview {
    WelcomeUserView(studentName: "Kenny Morales")
}
