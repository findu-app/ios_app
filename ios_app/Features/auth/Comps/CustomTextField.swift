//
//  CustomTextField.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/28/24.
//


//
//  CustomTextField.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/27/24.
//
import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var fontSize: CGFloat
    var isSecure: Bool = false
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(Font.custom("Plus Jakarta Sans", size: fontSize))
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            } else {
                TextField(placeholder, text: $text)
                    .font(Font.custom("Plus Jakarta Sans", size: fontSize))
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    @State var text = ""
    return VStack(spacing: 16) {
        CustomTextField(placeholder: "Email", text: $text, fontSize: 14)
        CustomTextField(placeholder: "Password", text: $text, fontSize: 16, isSecure: true)
    }
    .padding()
}
