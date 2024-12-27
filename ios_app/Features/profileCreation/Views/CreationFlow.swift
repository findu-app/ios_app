//
//  CreationFlow.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

struct CreationFlow: View {
    @State private var currentStep = 0
    let totalSteps = 5

    var body: some View {
        VStack(spacing: 48) {
            // Progress Bar
            ProgressStepper(totalSteps: totalSteps, currentStep: currentStep)

            // Substeps and Buttons in a ZStack
            ZStack(alignment: .topLeading) {
                // Substep Content
                VStack {
                    if currentStep == 0 {
                        Substep1()
                    } else {
                        Text("Other Steps")
                            .font(.system(size: 24))
                            .foregroundColor(Color("OnSurface"))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                // Continue Button
                VStack {
                    Button(action: {
                        handleContinue()
                    }) {
                        Text("Continue").font(Font.custom("Plus Jakarta Sans SemiBold", size: 16)).foregroundColor(Color("Surface"))
                    }.frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("OnSurface"))
                        .cornerRadius(10)
                }
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding(.horizontal, 24)
        .background(Color("Surface"))
    }
    
    private func handleContinue() {
            if currentStep < totalSteps - 1 {
                currentStep += 1
            }
            // Additional logic for validation can be added here
        }
}

#Preview {
    CreationFlow()
}
