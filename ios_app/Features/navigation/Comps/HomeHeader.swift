//
//  HomeHeader.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct HomeHeader: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack {
            Image(
                colorScheme == .dark
                    ? "finduLogoFull_dark" : "finduLogoFull_light"
            )
            .resizable()
            .scaledToFit()
            .frame(height: 24)

            Spacer()

            Button(action: {
                //TODO: Add this in the future so that it searches.
                print("Button pressed")
            }) {
                HStack(alignment: .center) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("OnSurface"))
                        .padding(4)
                }

            }

        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)

        Divider()
            .frame(height: 1)
            .background(Color("Border"))

    }

}

#Preview {
    HomeHeader()
}
