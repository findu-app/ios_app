//
//  FormButton.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/13/25.
//

import SwiftUI

struct FormButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    // Customization Options
    var font: String = "Plus Jakarta Sans"
    var fontSize: CGFloat = 14
    var foregroundColor: Color = Color("OnSurface")
    var selectedForegroundColor: Color = .white
    var backgroundColor: Color = Color("Surface")
    var selectedBackgroundColor: Color = Color("Primary")
    var showBorder: Bool = true
    var borderColor: Color = Color("Border")
    var selectedBorderColor: Color = Color(red: 172 / 255, green: 49 / 255, blue: 49 / 255)

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom(font, size: fontSize))
                .foregroundColor(isSelected ? selectedForegroundColor : foregroundColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(isSelected ? selectedBackgroundColor : backgroundColor)
                )
                .overlay(
                    showBorder ? RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? selectedBorderColor : borderColor, lineWidth: 1)
                        : nil
                )
                .overlay(
                    showBorder ? Rectangle()
                        .fill(isSelected ? selectedBorderColor : borderColor)
                        .frame(height: 3) : nil,
                    alignment: .bottom
                )
                .cornerRadius(10)
                .animation(.easeInOut, value: isSelected)
        }
    }
}

#Preview {
    FormButton(
        title: "Option",
        isSelected: true,
        action: {},
        font: "Plus Jakarta Sans",
        fontSize: 14,
        foregroundColor: .white,
        selectedForegroundColor: .black,
        backgroundColor: .gray,
        selectedBackgroundColor: .blue,
        showBorder: false
    )
}
