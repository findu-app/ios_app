//
//  NumberField.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct NumberField: View {
    @Binding var userInput: String // Raw input is stored here
    var keyboardType: UIKeyboardType
    var maxLength: Int
    var placeholder: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $userInput)
                .keyboardType(keyboardType)
                .focused($isFocused)
                .onChange(of: userInput) {
                    if userInput.count > maxLength {
                        userInput = String(userInput.prefix(maxLength))
                    }
                }
                .padding(20.0)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SurfaceContainer"))
                        .stroke(isFocused ? Color("OnSurface") : Color("Border"), lineWidth: 1)
                )
                .font(Font.custom("Plus Jakarta Sans Regular", size: 20))
                .toolbar {
                    // Conditionally display toolbar only when focused
                    if isFocused {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isFocused = false
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    NumberField(userInput: .constant("1234567890"), keyboardType: .numberPad, maxLength: 4, placeholder: "Enter number")
}
