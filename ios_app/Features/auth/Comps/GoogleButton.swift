//
//  GoogleButton.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//
import SwiftUI

struct GoogleButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8.0) {
                Image("googleIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                
                Text("Continue with Google")
                    .font(Font.custom("Plus Jakarta Sans SemiBold", size: 16))
                    .foregroundColor(Color("onSurface"))
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("SurfaceContainer"))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("Border"), lineWidth: 1)
            )
        }
    }
}

#Preview {
    GoogleButton { }
}
