//
//  SingleSelectBtns.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

struct SingleSelectBtns: View {
    @Binding var selectedOption: String
    let options: [String]

    var body: some View {
        VStack(spacing: 12) { // Stack buttons vertically with spacing
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option // Update selected option
                }) {
                    Text(option)
                        .padding(.vertical, 22)
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 14))
                        .fontWeight(selectedOption == option ? .semibold : .regular)
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == option ? Color("Primary").opacity(0.2) : Color("SurfaceContainer"))
                        .foregroundColor(selectedOption == option ? Color("Primary") : Color("Secondary"))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedOption == option ? Color("Primary") : Color("Border"),
                                    lineWidth: 1
                                )
                        )
                }
            }
        }
    }
}

#Preview {
    SingleSelectBtns(selectedOption: .constant("Phone"),options: ["Email", "Phone", "Messages"])
}
