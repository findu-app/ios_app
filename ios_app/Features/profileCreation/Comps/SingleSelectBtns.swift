//
//  SingleSelectBtns.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

struct SingleSelectBtns: View {
    let options: [String] // Accept options as a prop
    @State private var selectedOption: String? = nil // Track selected option

    var body: some View {
        VStack(spacing: 16) { // Stack buttons vertically with spacing
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option // Update selected option
                }) {
                    Text(option)
                        .padding()
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                        .fontWeight(selectedOption == option ? .semibold : .regular)
                        .frame(maxWidth: .infinity)
                        .background(selectedOption == option ? Color("Primary") : Color("SurfaceContainer"))
                        .foregroundColor(selectedOption == option ? Color("OnPrimary") : Color("Secondary"))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    selectedOption == option ? Color.clear : Color("Border"),
                                    lineWidth: 1
                                )
                        )
                }
            }
        }
    }
}

#Preview {
    SingleSelectBtns(options: ["Email", "Phone", "Messages"])
}
