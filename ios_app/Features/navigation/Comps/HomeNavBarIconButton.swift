//
//  HomeNavBarIconButton.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//


import SwiftUI

struct HomeNavBarIconButton: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.title)
            Text(label)
                .font(Font.custom("Plus Jakarta Sans Regular", size: 9))
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(isSelected ? Color("primary") : Color("onSurface"))
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    HomeNavBarIconButton(icon: "heart", label: "Saved", isSelected: true, action: {})
}
