//
//  StudentProfileCreationFlow.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

struct StudentProfileCreationFlow: View {
    @State private var studentData = StudentProfileData()
    @State private var currentSectionIndex: Int = 0
    @State private var currentStepIndex: Int = 0

    @EnvironmentObject var globalStudentState: GlobalStudentDataState  // Access GlobalStudentState

    private let validator = SignupValidator()
    @State private var validationError: String?

    private var steps: [(section: String, views: [() -> AnyView])] {
        CreationFlowSteps.steps(studentData: $studentData)
    }

    private var currentSection: String {
        steps[currentSectionIndex].section
    }

    private var currentSteps: [() -> AnyView] {
        steps[currentSectionIndex].views
    }

    private var isStepValid: Bool {
        validator.validate(
            section: currentSection,
            substepIndex: currentStepIndex,
            data: studentData
        )
    }

    private var isLastStep: Bool {
        currentSectionIndex == steps.count - 1
            && currentStepIndex == currentSteps.count - 1
    }

    var body: some View {
        ZStack {
            // Main Content
            VStack(spacing: 24) {
                // Progress Bar
                ProgressStepper(
                    totalSteps: totalSteps,
                    currentStep: completedSteps,
                    currentSection: currentSection
                )

                // Render current step
                if currentStepIndex < currentSteps.count {
                    currentSteps[currentStepIndex]()
                } else {
                    Text("Step not found!")
                        .font(.system(size: 24))
                        .foregroundColor(Color("OnSurface"))
                }

                Spacer()  // Push content up
            }

            // Continue Button
            VStack {
                Spacer()  // Push button to the bottom
                Button(action: handleContinue) {
                    Text(isLastStep ? "Complete Profile" : "Continue")
                        .font(
                            Font.custom("Plus Jakarta Sans SemiBold", size: 16)
                        )
                        .foregroundColor(
                            isStepValid ? Color("OnPrimary") : Color("Border")
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                }
                .frame(maxWidth: .infinity)
                .background(
                    isStepValid ? Color("Primary") : Color("Secondary")
                )
                .cornerRadius(10)
                .disabled(!isStepValid)
            }
            .padding(.vertical, 20)
        }
        .padding(.horizontal, 16)
        .background(Color("Surface"))
    }

    // Helpers
    private var totalSteps: Int {
        steps.flatMap { $0.views }.count
    }

    private var completedSteps: Int {
        steps.prefix(currentSectionIndex).flatMap { $0.views }.count
            + currentStepIndex
    }

    private func handleContinue() {
        if isStepValid {
            validationError = nil
            if currentStepIndex < currentSteps.count - 1 {
                // Move to the next step in the current section
                currentStepIndex += 1
            } else if currentSectionIndex < steps.count - 1 {
                // Move to the next section
                currentSectionIndex += 1
                currentStepIndex = 0
            } else {
                // If on the last step, save the student profile
                let studentInfo = studentData.toStudentInfo()  // Transform the data
                globalStudentState.saveStudentInfo(from: studentInfo)  // Save globally
            }
        } else {
            validationError = "Please complete this step before continuing."
        }
    }
}

#Preview {
    StudentProfileCreationFlow()
}
