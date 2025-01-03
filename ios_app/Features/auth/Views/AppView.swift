//
//  AppView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/28/24.
//


import SwiftUI

struct AppView: View {
  @State var isAuthenticated = false

  var body: some View {
    Group {
      if isAuthenticated {
        SuccessView()
      } else {
        WelcomeView()
      }
    }
    .task {
      for await state in supabase.auth.authStateChanges {
        if [.initialSession, .signedIn, .signedOut].contains(state.event) {
          isAuthenticated = state.session != nil
        }
      }
    }
  }
}

#Preview {
    AppView()
}
