//
//  AppleButton.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//

import SwiftUI

struct AppleButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8.0) {
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .foregroundColor(Color("surface"))
                
                Text("Continue with Apple").font(Font.custom("Plus Jakarta Sans SemiBold", size: 16))
                    .foregroundColor(Color("surface"))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("onSurface"))
            .cornerRadius(10)
        }
    }
}

#Preview {
    AppleButton{
        }
}
