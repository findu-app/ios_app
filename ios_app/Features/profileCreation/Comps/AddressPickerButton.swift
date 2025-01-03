//
//  AddressPickerButton.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI

struct AddressPickerButton: View {
    @Binding var selectedAddress: String
    @Binding var isSheetOpen: Bool

    var body: some View {
        Button(action: {
            isSheetOpen = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .fontWeight(selectedAddress == "" ? .regular : .regular)
                    .foregroundColor(
                        selectedAddress == ""
                            ? Color("Secondary") : Color("SurfaceContainer"))

                Text(selectedAddress == "" ? "Add Address" : "Change Address")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                    .fontWeight(selectedAddress == "" ? .regular : .regular)
                    .foregroundColor(
                        selectedAddress == ""
                            ? Color("Secondary") : Color("SurfaceContainer"))
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 18)

        }
        .frame(maxWidth: .infinity)
        .background(
            selectedAddress == ""
                ? Color("SurfaceContainer") : Color("Secondary")
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    selectedAddress == "" ? Color("Border") : Color.clear,
                    lineWidth: 2)
        )
        .cornerRadius(10)
    }
}

#Preview {
    AddressPickerButton(
        selectedAddress: .constant(""),
        isSheetOpen: .constant(false)
    )
}
