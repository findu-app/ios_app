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
            HStack {
                Image(systemName: "applelogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16)
                    .foregroundColor(.white)
                
                Text("Continue with Apple")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.black)
            .cornerRadius(8)
        }
    }
}
