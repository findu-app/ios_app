//
//  LoginWithEmailView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/27/24.
//


import SwiftUI
import Supabase

struct LoginWithEmailView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @EnvironmentObject var supabaseClient: SupabaseClient
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Log in")
                .font(.title)
                .fontWeight(.bold)
            
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: handleLogin) {
                    Text("Log in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Spacer()
            
            HStack {
                Text("Don’t have an account?")
                Button(action: {
                    // Navigate to SignupView
                }) {
                    Text("Create an Account")
                        .fontWeight(.semibold)
                }
            }
            .padding(.bottom)
        }
        .padding()
    }
    
    func handleLogin() {
        Task {
            do {
                let session = try await supabaseClient.auth.signIn(email: email, password: password)
                print("Logged in: \(session)")
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
