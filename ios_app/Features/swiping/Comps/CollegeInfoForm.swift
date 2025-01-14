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
    @State private var likedMost: [String] = []
    @State private var worriedAbout: [String] = []
    @State private var questions: String = ""
    let onSubmit: (StudentSchoolInteraction) -> Void

    var body: some View {
        VStack {
            if step == 1 {
                FormQuestion(
                    title: "What did you like the most about this school?",
                    options: ["Costs", "Academics", "Admissions", "Campus", "Financial Aid", "Special Programs", "Career"],
                    selectedOptions: $likedMost
                )

            } else if step == 2 {
                FormQuestion(
                    title: "What are you most worried about?",
                    options: ["Costs", "Academics", "Admissions", "Campus", "Financial Aid", "Special Programs", "Career"],
                    selectedOptions: $worriedAbout
                )

            } else {
                VStack(alignment: .center, spacing: 8) {
                    Text("Do you have any questions for an admissions officer?")
                        .font(.custom("Plus Jakarta Sans SemiBold", size: 20))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)

                    Text("This will send a message to an admissions officer")
                        .font(.custom("Plus Jakarta Sans Regular", size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 16)

                    TextEditor(text: $questions)
                        .font(.custom("Plus Jakarta Sans Regular", size: 16))
                        .frame(height: 150)
                        .padding(.horizontal)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 24)

                Spacer()
            }

            FormButton(
                title: step < 3 ? "Next" : "Submit",
                isSelected: false,
                action: {
                    if step < 3 {
                        step += 1
                    } else {
                        submitForm()
                    }
                },
                font: "Plus Jakarta Sans SemiBold",
                fontSize: 14,
                foregroundColor: Color("Surface"),
                backgroundColor: Color("OnSurface"),
                showBorder: false
            )
            .disabled(!validateCurrentStep())
            .opacity(validateCurrentStep() ? 1.0 : 0.5)
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

        interaction.likedMost = likedMost
        interaction.worriedAbout = worriedAbout
        interaction.questions = questions

        print("LikedMost: \(likedMost)")
        print("WorriedAbout: \(worriedAbout)")
        print("Questions: \(questions)")

        onSubmit(interaction)
    }
}
