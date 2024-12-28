//
//  EmailButton.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//
import SwiftUI

struct EmailButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8.0) {
                Image(systemName: "envelope")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .foregroundColor(Color("onPrimary"))
                
                Text("Continue with Email").font(Font.custom("Plus Jakarta Sans SemiBold", size: 16))
                    .foregroundColor(Color("onPrimary"))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("primary"))
            .cornerRadius(10.0)
        }
    }
}

#Preview {
    EmailButton{}
}
