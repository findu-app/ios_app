//
//  PhoneField.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

struct PhoneNumberTextField: View {
    @State private var phoneNumber: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField("(123) - 456 - 7890", text: $phoneNumber)
                .keyboardType(.numberPad)
                .scrollDismissesKeyboard(ScrollDismissesKeyboardMode.immediately)
                .focused($isFocused)
                .onChange(of: phoneNumber) { newValue in
                    phoneNumber = formatPhoneNumber(newValue)
                }
                .padding(16.0)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SurfaceContainer"))
                        .stroke(isFocused ? Color("OnSurface") : Color("Border"), lineWidth: 1)
                )
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .toolbar {
                    // Add Done button to the keyboard
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isFocused = false // Dismiss the keyboard
                        }
                    }
                }
        }
    }

    /// Formats the phone number into the standard US format (e.g., (123) 456-7890)
    private func formatPhoneNumber(_ number: String) -> String {
        let cleaned = number.filter { $0.isNumber }
        let mask = "(XXX) - XXX - XXXX"
        var result = ""
        var index = cleaned.startIndex

        for ch in mask where index < cleaned.endIndex {
            if ch == "X" {
                result.append(cleaned[index])
                index = cleaned.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

struct PhoneNumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberTextField()
    }
}
