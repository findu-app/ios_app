//
//  CollegeInfoForm.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/13/25.
//


import SwiftUI

struct CollegeInfoForm: View {
    @Binding var studentSchoolInteraction: StudentSchoolInteraction?
    @State private var step: Int = 1
    @State private var likedMost: String = ""
    @State private var worriedAbout: String = ""
    @State private var questions: String = ""
    let onSubmit: (StudentSchoolInteraction) -> Void

    var body: some View {
        VStack {
            if step == 1 {
                FormQuestion(
                    title: "What did you like the most about this school?",
                    options: ["Costs", "Academics", "Admissions", "Campus", "Financial Aid", "Special Programs", "Career"],
                    selectedOption: Binding(
                        get: { likedMost },
                        set: { likedMost = $0 }
                    )
                )
            } else if step == 2 {
                FormQuestion(
                    title: "What are you most worried about?",
                    options: ["Costs", "Academics", "Admissions", "Campus", "Financial Aid", "Special Programs", "Career"],
                    selectedOption: Binding(
                        get: { worriedAbout },
                        set: { worriedAbout = $0 }
                    )
                )
            } else {
                VStack(alignment: .leading) {
                    Text("Do you have any questions for an admissions officer?")
                        .font(.headline)
                        .padding(.bottom)
                    TextField("Type...", text: $questions)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                }
                Spacer()
            }

            Button(step < 3 ? "Next" : "Submit") {
                if step < 3 {
                    step += 1
                } else {
                    submitForm()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
            .disabled(!validateCurrentStep()) // Disable button unless the current step is valid
        }
        .padding()
    }
    
    private func validateCurrentStep() -> Bool {
        switch step {
        case 1:
            return !likedMost.isEmpty
        case 2:
            return !worriedAbout.isEmpty
        case 3:
            return !questions.isEmpty
        default:
            return false
        }
    }


    private func submitForm() {
        guard var interaction = studentSchoolInteraction else { return }

        // Update the interaction object
        interaction.likedMost = likedMost
        interaction.worriedAbout = worriedAbout
        interaction.questions = questions

        print("LikedMost: \(likedMost)")
        print("WorriedAbout: \(worriedAbout)")
        print("Questions: \(questions)")

        // Pass the updated interaction back to the parent
        onSubmit(interaction)
    }
}
