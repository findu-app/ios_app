//
//  AppearanceSettingsView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/15/25.
//

import SwiftUI

struct AppearanceSettingsView: View {
    @Binding var isOnSubPage: Bool // To track if the user is in a sub-page
    @State private var selectedAppearance: Appearance = .systemDefault // Current selected appearance option

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Back Button + Title
            HStack {
                Button(action: {
                    isOnSubPage = false // Notify parent to reset sub-page state
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Text("Settings")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 18))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.bottom, 16)

            // Title
            Text("Appearance")
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                .foregroundColor(.black)
                .padding(.bottom, 8)

            // Appearance Options List
            VStack(spacing: 0) {
                ForEach(Appearance.allCases, id: \.self) { appearance in
                    HStack {
                        Text(appearance.displayName)
                            .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                            .foregroundColor(.black)
                        Spacer()
                        if selectedAppearance == appearance {
                            Image(systemName: "checkmark")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color("Primary")) // Replace with your custom accent color
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white) // Set background for each row
                    .onTapGesture {
                        selectedAppearance = appearance // Update selection
                        // Handle logic for appearance change
                    }
                    
                    Divider() // Add divider between options
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("SurfaceContainer"))
            )

            Spacer()
        }
        .padding()
        .background(Color("Surface")) // Background color for the entire screen
        .navigationBarHidden(true)    // Hide the default navigation bar
    }
}

enum Appearance: String, CaseIterable {
    case systemDefault = "System Default"
    case dark = "Dark"
    case light = "Light"

    var displayName: String {
        switch self {
        case .systemDefault:
            return "System Default"
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        }
    }
}

#Preview {
    AppearanceSettingsView(isOnSubPage: .constant(true))
}
