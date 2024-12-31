//
//  StringField.swift
//  ios_app
//
//  Created by Kenny Morales on 12/29/24.
//

import SwiftUI

struct StringTextField: View {
    @Binding var userInput: String
    var placeholder: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $userInput)
                .focused($isFocused)
                .padding(16.0)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("SurfaceContainer"))
                        .stroke(
                            isFocused ? Color("OnSurface") : Color("Border"),
                            lineWidth: 1)
                )
                .textInputAutocapitalization(.words)
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .toolbar {
                    // Add Done button to the keyboard
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isFocused = false
                            print(userInput)
                        }
                    }
                }
        }
    }

}

#Preview {
    StringTextField(userInput: .constant(""), placeholder: "Wow")
}
