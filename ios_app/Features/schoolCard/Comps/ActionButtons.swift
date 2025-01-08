//
//  ActionButtons.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/8/25.
//

import SwiftUI

struct ActionButtons: View {
    var onDislike: () -> Void
    var onReverse: () -> Void
    var onLike: () -> Void

    var body: some View {
        HStack {
            Button(action: onDislike) {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(Color("primary"))
            }

            Spacer()

            Button(action: onReverse) {
                Image(systemName: "arrow.counterclockwise")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(Color.white)
            }

            Spacer()

            Button(action: onLike) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .foregroundColor(Color(red: 2/255, green: 255/255, blue: 127/255))
            }
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
        .padding(.top, 8)
        .padding(.horizontal, 8)
    }
}

struct ActionButtons_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtons(
            onDislike: { print("Disliked") },
            onReverse: { print("Reversed") },
            onLike: { print("Liked") }
        )
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
