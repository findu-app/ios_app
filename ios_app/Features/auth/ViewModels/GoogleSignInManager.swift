//
//  GoogleSignInManager.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/31/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

class GoogleSignInManager {
    static let shared = GoogleSignInManager() // Singleton instance for centralized sign-in logic

    /// Initiates the Google sign-in flow and handles authentication with Supabase.
    /// - Parameter completion: A closure returning a `Result` indicating success or an error.
    func signIn(completion: @escaping (Result<Void, Error>) -> Void) {
        // Ensure the app has access to the current top-most view controller for Google Sign-In
        guard let topVC = UIApplication.getTopViewController() else {
            completion(.failure(
                NSError(
                    domain: "GoogleSignIn",
                    code: -1,
                    userInfo: [NSLocalizedDescriptionKey: "Unable to get top view controller"]
                )
            ))
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: topVC) { signInResult, error in
            // Handle potential error in initiating Google Sign-In
            if let error = error {
                completion(.failure(error))
                return
            }

            // Verify the result is non-nil before proceeding
            guard let signInResult = signInResult else {
                completion(.failure(
                    NSError(
                        domain: "GoogleSignIn",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Google Sign-In result is nil"]
                    )
                ))
                return
            }

            // Refresh authentication tokens to ensure they are valid
            signInResult.user.refreshTokensIfNeeded { user, refreshError in
                if let refreshError = refreshError {
                    completion(.failure(refreshError))
                    return
                }

                // Ensure user and ID token are valid for further processing
                guard let user = user, let idToken = user.idToken else {
                    completion(.failure(
                        NSError(
                            domain: "GoogleSignIn",
                            code: -1,
                            userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user or ID token"]
                        )
                    ))
                    return
                }

                // Authenticate the user with Supabase using the Google ID token
                Task {
                    do {
                        let response = try await supabase.auth.signInWithIdToken(
                            credentials: .init(provider: .google, idToken: idToken.tokenString)
                        )
                        DispatchQueue.main.async {
                            completion(.success(()))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
