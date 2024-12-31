//
//  HighSchoolButton.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI

struct HSButton: View {
    @Binding var selectedHS: String
    @Binding var isSheetPresented: Bool

    var body: some View {
        Button(action: {
            isSheetPresented = true
        }) {
            HStack(spacing: 8) {
                Image(systemName: "graduationcap")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 16)
                    .fontWeight(selectedHS == "" ? .regular : .regular)
                    .foregroundColor(selectedHS == "" ? Color("Secondary") : Color("SurfaceContainer"))
                
                Text(selectedHS == "" ? "Select School" : "Change School")
                    .font(Font.custom("Plus Jakarta Sans SemiBold", size: 16))
                    .fontWeight(selectedHS == "" ? .regular : .regular)
                    .foregroundColor(selectedHS == "" ? Color("Secondary") : Color("SurfaceContainer"))
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 18)
           
        }
        .frame(maxWidth: .infinity)
        .background(selectedHS == "" ? Color("SurfaceContainer") : Color("Secondary"))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    selectedHS == "" ? Color("Border") : Color.clear, lineWidth: 2)
                )
        .cornerRadius(10)
    }
}

#Preview {
    HSButton(
        selectedHS: .constant(""),
        isSheetPresented: .constant(false)
    )
}
