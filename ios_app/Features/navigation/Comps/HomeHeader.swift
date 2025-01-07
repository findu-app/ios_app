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
            Image(colorScheme == .dark ? "finduLogoFull_dark" : "finduLogoFull_light")
                .resizable()
                .scaledToFit()
                .frame(width: 95)

            Spacer()
            
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(Color("onSurface"))
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color("surface"))
        
        Divider()
            .frame(height: 1)
            .background(Color.gray.opacity(0.5))

    }
}

#Preview {
    HomeHeader()
}
