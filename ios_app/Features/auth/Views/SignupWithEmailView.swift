//
//  LoginWithEmailView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/27/24.
//


import SwiftUI

struct SignupWithEmailView: View {
    @Binding var path: [String]
    @StateObject private var viewModel = SignupWithEmailViewModel()
    @State private var isModalPresented: Bool = false

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 180)
            
            Text("Create an Account")
                .font(Font.custom("Plus Jakarta Sans Bold", size: 32.0))
                .fontWeight(.semibold)
            
            VStack(spacing: 24) {
                CustomTextField(placeholder: "Email", text: $viewModel.email, fontSize: 14)
                CustomTextField(placeholder: "Password", text: $viewModel.password, fontSize: 16, isSecure: true)
                CustomTextField(placeholder: "Confirm Password", text: $viewModel.confirmPassword, fontSize: 16, isSecure: true)
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                IconButton(iconName: "", text: "Sign Up") {
                    viewModel.handleSignup(path: $path, isModalPresented: $isModalPresented)
                }
            }
            .padding()
            
            Spacer()
                .frame(height: 174)
            
            VStack(spacing: 8) {
                Text("Already have an account?")
                    .foregroundColor(Color("Secondary"))
                
                IconButton(
                    iconName: "",
                    text: "Log In",
                    action: { path.removeAll(); path.append("login") },
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
        .overlay(
            Group {
                if isModalPresented {
                    VStack {
                        Text("Confirm Account In Your Email")
                            .font(Font.custom("Plus Jakarta Sans Light", size: 24.0))
                            .padding()
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        IconButton(iconName: "envelope", text: "OK") {
                            isModalPresented = false
                            path.removeAll()
                            path.append("login")
                        }
                        .frame(width: 200, height: 50)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("Border"), lineWidth: 3)
                    )
                    .background(Color("allWhite"))
                    .foregroundColor(Color("OnSurface"))
                    .cornerRadius(10)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
                }
            }
        )
    }
}

struct SignupWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignupWithEmailView(path: .constant([]))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
