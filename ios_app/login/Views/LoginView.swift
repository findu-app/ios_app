//
//  LoginView.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/26/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Welcome Text
            Text("Welcome to")
                .font(.system(size: 32))
                .foregroundColor(Color(red: 111/255, green: 111/255, blue: 111/255))
            // Logo
            Image("finduLogoFull")
                .resizable()
                .scaledToFit()
                .frame(width: 250)
            
            Spacer()

            // Continue Buttons
            VStack(spacing: 16) {
                Button(action: {
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                            .foregroundColor(.white)
                            .alignmentGuide(.lastTextBaseline) { dimensions in
                                            dimensions[VerticalAlignment.center]
                                        }

                        Text("Continue with Apple")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(8)
                    

                }

                Button(action: {
                }) {
                    HStack {
                        Image("googleIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16)
                        Text("Continue with Google")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }

                Button(action: {
                }) {
                    HStack {
                        Text("Continue with Email")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 229/255, green: 73/255, blue: 73/255))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)

            Spacer()
                .frame(height: 30)
        }
        .background(Color(.systemGray6))
    }
}

#Preview {
    LoginView()
}
