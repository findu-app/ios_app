//
//  MultiSelectBtns.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI
import WrappingHStack

struct MultiSelectBtns: View {
    @Binding var selectedOptions: [String]  // Holds the selected options
    let options: [String]  // Available options

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Select Options")
                .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                .foregroundColor(Color("OnSurface"))

            ScrollView {
                WrappingHStack(options, id: \.self, spacing: .constant(8), lineSpacing: 8) { option in
                    Button(action: {
                        toggleSelection(for: option)
                    }) {
                        Text(option)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .font(Font.custom("Plus Jakarta Sans Medium", size: 12))
                            .background(
                                selectedOptions.contains(option)
                                    ? Color("Primary").opacity(0.2)
                                    : Color("SurfaceContainer")
                            )
                            .foregroundColor(
                                selectedOptions.contains(option)
                                    ? Color("Primary")
                                    : Color("OnSurface")
                            )
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        selectedOptions.contains(option)
                                            ? Color("Primary")
                                            : Color("Border"),
                                        lineWidth: 1
                                    )
                            )
                    }
                }
                .padding(.top, 12)
                .padding(.horizontal, 1)
            }
        }
        .padding()
    }

    /// Toggles the selection for a given option
    private func toggleSelection(for option: String) {
        if let index = selectedOptions.firstIndex(of: option) {
            // Remove option if already selected
            selectedOptions.remove(at: index)
        } else {
            // Add option to selected list
            selectedOptions.append(option)
        }
    }
}

#Preview {
    MultiSelectBtns(
        selectedOptions: .constant(["🏀   Basketball"]),
        options: [
            "🏀   Basketball", "🎨   Art", "🎸   Music", "📚   Reading", "💻   Coding",
            "🎮   Gaming", "🍳   Cooking", "🏋️‍♀️   Fitness", "🎤   Singing", "✈️   Travel"
        ]
    )
}
