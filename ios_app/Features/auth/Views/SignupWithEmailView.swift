//
//  LoginWithEmailView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/27/24.
//


import SwiftUI
import Supabase

struct SignupWithEmailView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Log in")
                .font(.title)
                .fontWeight(.semibold)
            
            VStack(spacing: 24) {
                CustomTextField(placeholder: "Email", text: $email, fontSize: 14)
                CustomTextField(placeholder: "Password", text: $password, fontSize: 16, isSecure: true)
                CustomTextField(placeholder: "Confirm Password", text: $password, fontSize: 16, isSecure: true)

                IconButton(iconName: "", text: "Login") {
                    print("Login button tapped")
                }
            }
            .padding()
            
            Spacer()
                .frame(height: 243)
            
            VStack {
                Text("Don’t have an account?")
                    .foregroundColor(Color("secondary"))
                IconButton(
                    iconName: "",
                    text: "Create an Accouxnt",
                    action: { print("Apple button tapped") },
                    backgroundColor: Color("SurfaceContainer"),
                    foregroundColor: Color("onSurface")
                )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("Border"), lineWidth: 1)
                    )
            }
            .padding(.bottom)
        }
        .padding()
    }
    
//    func handleLogin() {
//        Task {
//            do {
//                let session = try await supabaseClient.auth.signIn(email: email, password: password)
//                print("Logged in: \(session)")
//            } catch {
//                errorMessage = error.localizedDescription
//            }
//        }
//    }
}


#Preview {
    LoginWithEmailView()
}
