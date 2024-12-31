//
//  ProgressStepper.swift
//  ios_app
//
//  Created by Kenny Morales on 12/28/24.
//

import SwiftUI

struct ProgressStepper: View {
    var totalSteps: Int // Total number of steps
    var currentStep: Int // Current step index (0-based)
    var currentSection : String

    var body: some View {
            VStack (spacing: 8){
                // Progress View
                ProgressView(value: progressValue())
                    .progressViewStyle(LinearProgressViewStyle(tint: Color("OnSurface")))
                    .background(Color("SurfaceContainer")) // Background bar color
                    .cornerRadius(2)
                    .frame(width: .infinity, height: 4)                .animation(.easeInOut(duration: 0.3), value: currentStep)
                Text(currentSection).font(Font.custom("Plus Jakarta Sans Medium", size: 14))
                    .foregroundColor(Color("OnSurface"))
            }
            .padding(.vertical, 12)
        }
            

    private func progressValue() -> Double {
        guard totalSteps > 1 else { return 0.0 }
        let progress = Double(currentStep) / Double(totalSteps - 1)
        return min(progress, 0.99)
    }
}

#Preview {
    VStack {
        ProgressStepper(totalSteps: 5, currentStep: 5, currentSection: "About Me")
            .padding()
    }
}
