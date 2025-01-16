//
//  AboutAppView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/15/25.
//

import SwiftUI

struct AboutAppView: View {
    @Binding var isOnSubPage: Bool // Access navigation state
    @Environment(\.presentationMode) var presentationMode // Environment to handle navigation dismissal

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Back Button + Title
            HStack {
                Button(action: {
                    isOnSubPage = false // Notify HomeView to reset the state
                    presentationMode.wrappedValue.dismiss() // Dismiss the current view
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Color("OnSurface"))
                    Text("Settings")
                        .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                        .foregroundColor(Color("OnSurface"))
                }                
            }
            .padding(.bottom, 16)

            // Title
            Text("About the app")
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                .foregroundColor(Color("OnSurface"))
                .padding(.bottom, 8)

            // Content
            Text("""
            Hey, we are the developers of FindU! We are both college students and are passionate about creating innovative solutions that help people connect and find new friends on campus.

            Our goal is to make socializing easier and more enjoyable for everyone.
            """)
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .foregroundColor(Color("OnSurface"))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("SurfaceContainer"))
                )

            Spacer()
        }
        .padding()
        .background(Color("Surface"))
        .navigationBarHidden(true) // Ensure default navigation bar is hidden
    }
}

#Preview {
    AboutAppView(isOnSubPage: .constant(false))
}
