//
//  LoginWithEmailViewModel.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/29/24.
//

import SwiftUI
import Supabase

class LoginWithEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    /// Handles the login process by calling Supabase authentication.
    ///
    /// - Parameter path: A binding to a path array for navigation.
    func handleLogin(path: Binding<[String]>) {
        // Ensure both email and password are provided
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter both email and password."
            return
        }

        // Perform login asynchronously on the main thread
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }

            do {
                // Try signing in with Supabase credentials
                let response = try await supabase.auth.signIn(email: email, password: password)

                // Navigate on success
                path.wrappedValue.append("success")
            } catch {
                // Handle errors that occur during sign-in
                errorMessage = "Error logging in: \(error.localizedDescription)"
            }
        }
    }
}
