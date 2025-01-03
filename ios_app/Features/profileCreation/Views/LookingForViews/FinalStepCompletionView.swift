//
//  FinalStepCompletionView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct FinalStepCompletionView: View {

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 20) {
                Image("school-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 72)

                Text("Woo! That was a lot. We appreciate your time and effort!")
                    .font(Font.custom("Plus Jakarta Sans Bold", size: 32))

                Text("Now begin looking for the perfect college!")
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
    FinalStepCompletionView()
}
