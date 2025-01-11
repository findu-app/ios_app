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
        VStack (spacing: 4) {
            Image(systemName: isSelected ? "\(icon).fill" : icon)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
            
            Text(label)
                .font(Font.custom("Plus Jakarta Sans Regular", size: 9))
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(isSelected ? Color("Primary") : Color("OnSurface"))
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    HomeNavBarIconButton(icon: "heart", label: "Saved", isSelected: true, action: {})
}
