//
//  LoginView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/26/24.
//

import Foundation
import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var path: [String] = []

    var body: some View {
        // The NavigationStack is responsible for managing the view navigation.
        // The 'path' is used to determine the navigation stack's state and push new views onto it.
        NavigationStack(path: $path) {
            VStack {
                Spacer()
                
                Text("Welcome to")
                    .font(Font.custom("Plus Jakarta Sans Light", size: 32.0))
                    .foregroundColor(Color("Secondary"))
                
                Image(colorScheme == .dark ? "finduLogoFull_dark" : "finduLogoFull_light")
                
                Spacer()
                
                VStack(spacing: 16) {
                    AppleButton {
                        print("Apple button tapped")
                    }
                    
                    GoogleButton {
                        GoogleSignInManager.shared.signIn { result in
                            switch result {
                            case .success:
                                path.append("success")
                            case .failure(let error):
                                print("Google Sign-In error: \(error.localizedDescription)")
                            }
                        }
                    }

                    IconButton(iconName: "envelope", text: "Continue with Email") {
                        path.append("login")
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
                    .frame(height: 52)
            }
            .edgesIgnoringSafeArea(.all)
            // Define the navigation destinations based on the string values in 'path'.
            // When 'path' contains a value, the corresponding view is presented.
            .navigationDestination(for: String.self) { view in
                switch view {
                    case "login":
                        LoginWithEmailView(path: $path)
                    case "signup":
                        SignupWithEmailView(path: $path)
                    case "success":
                        SuccessView()
                    default:
                        EmptyView()
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
