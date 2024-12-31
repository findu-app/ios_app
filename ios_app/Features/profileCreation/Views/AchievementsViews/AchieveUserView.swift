//
//  AchieveUserView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct AchieveUserView: View {

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 20) {
                Image("hand-write-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 72)

                Text("Let’s look at what you’ve achieved")
                    .font(Font.custom("Plus Jakarta Sans Bold", size: 32))

                Text("Be as honest as possible!")
                    .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                    .foregroundColor(Color("OnSurface"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 128)

            Spacer()
        }
        .frame(maxWidth: .infinity)  // Ensure parent VStack also fills the width
    }

}

#Preview {
    AchieveUserView()
}
