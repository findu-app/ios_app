//
//  LoginWithEmailView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/27/24.
//


import SwiftUI

struct LoginWithEmailView: View {
    @Binding var path: [String]
    @StateObject private var viewModel = LoginWithEmailViewModel()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 180)
            
            Text("Log In")
                .font(Font.custom("Plus Jakarta Sans Bold", size: 32.0))
                .fontWeight(.semibold)
            
            VStack(spacing: 24) {
                CustomTextField(placeholder: "Email", text: $viewModel.email, fontSize: 14)
                CustomTextField(placeholder: "Password", text: $viewModel.password, fontSize: 16, isSecure: true)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                IconButton(iconName: "", text: "Log In") {
                    viewModel.handleLogin(path: $path)
                }
            }
            .padding()
            
            Spacer()
                .frame(height: 243)
            
            VStack(spacing: 8) {
                Text("Don't have an account?")
                    .foregroundColor(Color("Secondary"))
                
                IconButton(
                    iconName: "",
                    text: "Sign Up",
                    action: { path.removeAll(); path.append("signup") },
                    backgroundColor: Color("SurfaceContainer"),
                    foregroundColor: Color("OnSurface")
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("Border"), lineWidth: 1)
                )
            }
            .padding(.bottom)
            
            Spacer()
                .frame(height: 61)
        }
        .padding()
        .navigationBarBackButtonHidden(false)
        .edgesIgnoringSafeArea(.all)
    }
}

