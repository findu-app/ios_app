//
//  PhoneNumberTextField.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct PhoneNumberTextField: View {
    @Binding var userInput: String  // Raw input is stored here
    var placeholder: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $userInput)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .onChange(of: userInput) { newValue in
                    // Enforce a max length of 10 characters
                    if userInput.count > 10 {
                        userInput = String(userInput.prefix(10))
                    }
                }
                .padding(16.0)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SurfaceContainer"))
                        .stroke(
                            isFocused ? Color("OnSurface") : Color("Border"),
                            lineWidth: 1)
                )
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
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
    PhoneNumberTextField(
        userInput: .constant("1234567890"), placeholder: "(XXX) - XXX - XXXX")
}
