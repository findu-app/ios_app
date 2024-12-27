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
            HStack {
                Text("Continue with Email")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 229/255, green: 73/255, blue: 73/255))
            .cornerRadius(8)
        }
    }
}
