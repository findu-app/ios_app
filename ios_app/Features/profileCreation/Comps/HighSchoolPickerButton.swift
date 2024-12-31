//
//  HighSchoolPickerButton.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI

struct HighSchoolPickerButton: View {
    @Binding var selectedHighSchool: String
    @Binding var isSheetOpen: Bool

    var body: some View {
        Button(action: {
            isSheetOpen = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "graduationcap")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .fontWeight(selectedHighSchool == "" ? .regular : .regular)
                    .foregroundColor(
                        selectedHighSchool == ""
                            ? Color("Secondary") : Color("SurfaceContainer"))

                Text(
                    selectedHighSchool == "" ? "Select School" : "Change School"
                )
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 16))
                .fontWeight(selectedHighSchool == "" ? .regular : .regular)
                .foregroundColor(
                    selectedHighSchool == ""
                        ? Color("Secondary") : Color("SurfaceContainer"))
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 18)

        }
        .frame(maxWidth: .infinity)
        .background(
            selectedHighSchool == ""
                ? Color("SurfaceContainer") : Color("Secondary")
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    selectedHighSchool == "" ? Color("Border") : Color.clear,
                    lineWidth: 2)
        )
        .cornerRadius(10)
    }
}

#Preview {
    HighSchoolPickerButton(
        selectedHighSchool: .constant(""),
        isSheetOpen: .constant(false)
    )
}
