//
//  SuccessView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/28/24.
//

import SwiftUI
import Supabase

struct SuccessView: View {

    func handleSignOut() {
        Task {
            do {
                try await supabase.auth.signOut()
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }


    var body: some View {
        VStack {
            Text("Logged in successfully!")
                .font(.title)
                .fontWeight(.semibold)
                .padding()

            IconButton(iconName: "", text: "Sign Out") {
                handleSignOut()
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    SuccessView()
}
