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
                    .background(Color("SurfaceContainer"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Border"), lineWidth: 1)
                    )
            } else {
                TextField(placeholder, text: $text)
                    .font(Font.custom("Plus Jakarta Sans", size: fontSize))
                    .autocapitalization(.none)
                    .padding()
                    .background(Color("SurfaceContainer"))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Border"), lineWidth: 1)
                    )
            }
        }
    }
}

struct CustomTextFieldPreview: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 16) {
            CustomTextField(placeholder: "Email", text: $email, fontSize: 14)
            CustomTextField(placeholder: "Password", text: $password, fontSize: 16, isSecure: true)
        }
        .padding()
    }
}

#Preview {
    CustomTextFieldPreview()
}
