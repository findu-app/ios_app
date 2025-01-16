//
//  AppearanceSettingsView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/15/25.
//

import SwiftUI

struct AppearanceSettingsView: View {
    @Binding var isOnSubPage: Bool  // Access navigation state\
    @AppStorage("selectedAppearance") private var selectedAppearance: String =
        "system"
    @Environment(\.presentationMode) var presentationMode  // Handle dismiss action

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // Back Button + Title
            HStack {
                Button(action: {
                    isOnSubPage = false  // Notify HomeView to reset the state
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color("OnSurface"))
                    Text("Settings")
                        .font(.custom("Plus Jakarta Sans Regular", size: 16))
                        .foregroundColor(Color("OnSurface"))
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)

            Text("Appearance")
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                .foregroundColor(Color("OnSurface"))
                .padding(.horizontal, 16)

            // Appearance Options in Section
            List {
                Section(
                    header: Text("App theme").font(
                        .custom("Plus Jakarta Sans Regular", size: 14)
                    ).foregroundColor(.gray)
                ) {
                    ForEach(["Match Settings", "Dark", "Light"], id: \.self) {
                        mode in
                        Button(action: {
                            selectedAppearance = mode.lowercased()
                        }) {
                            HStack {
                                Text(mode)
                                    .font(
                                        .custom(
                                            "Plus Jakarta Sans Regular",
                                            size: 16)
                                    )
                                    .foregroundColor(.primary)
                                Spacer()
                                if selectedAppearance == mode.lowercased() {
                                    Image(systemName: "checkmark")
                                        .font(
                                            .system(size: 18, weight: .semibold)
                                        )
                                        .foregroundColor(Color("Primary"))
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .scrollContentBackground(.hidden)
            .background(Color("Surface"))

            Spacer()
        }
        .background(Color("Surface"))
        .navigationBarHidden(true)
    }
}
