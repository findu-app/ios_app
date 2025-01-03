//
//  IconButton.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//

import SwiftUI

struct IconButton: View {
    var iconName: String
    var text: String
    var action: () -> Void
    var backgroundColor: Color = Color("primary")
    var foregroundColor: Color = Color("onPrimary")
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8.0) {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .foregroundColor(foregroundColor)
                
                Text(text)
                    .font(Font.custom("Plus Jakarta Sans SemiBold", size: 16))
                    .foregroundColor(foregroundColor)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(10.0)
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        IconButton(
            iconName: "envelope",
            text: "Continue with Email",
            action: { print("Email Button tapped") },
            backgroundColor: Color("secondary"),
            foregroundColor: Color("onSurface")
        )
        
        IconButton(
            iconName: "book",
            text: "Default Colors",
            action: { print("Default Button tapped") }
        )
    }
    .padding()
}
