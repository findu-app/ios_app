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
            HStack {
                Image("googleIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
                
                Text("Continue with Google")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
}
