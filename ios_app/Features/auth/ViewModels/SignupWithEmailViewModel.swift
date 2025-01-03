//
//  SignupWithEmailViewModel.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/29/24.
//

import SwiftUI
import Supabase

class SignupWithEmailViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String?
    @Published var isSuccessful: Bool = false

    /// Handles the sign-up process by calling Supabase authentication.
    ///
    /// - Parameters:
    ///   - path: A binding to a path array for navigation.
    ///   - isModalPresented: A binding to control modal presentation state.
    func handleSignup(path: Binding<[String]>, isModalPresented: Binding<Bool>) {
        // Ensure passwords match
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }

        // Perform sign-up asynchronously
        Task {
            do {
                // Try signing up with Supabase credentials
                let response = try await supabase.auth.signUp(email: email, password: password)
                isSuccessful = true

                // Update UI to show modal on successful sign-up
                DispatchQueue.main.async {
                    isModalPresented.wrappedValue = true
                }
            } catch {
                // Handle errors that occur during sign-up
                errorMessage = "Error signing up: \(error.localizedDescription)"
            }
        }
    }
}
