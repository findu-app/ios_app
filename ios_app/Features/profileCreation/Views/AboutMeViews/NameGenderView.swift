//
//  NameGenderInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

struct NameGenderInputView: View {
    @Binding var studentName: String
    @Binding var studentGender: String

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 36.0) {
                // Name Input
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What's your full name?").centeredTitleTextStyle()
                    
                    StringField(
                        userInput: $studentName,
                        placeholder: "Enter your name"
                    )
                }

                // Gender Selection
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What's your gender?").centeredTitleTextStyle()
                    
                    SingleSelectBtns(
                        selectedOption: $studentGender,
                        options: Gender.allCases.map { $0.rawValue }
                    )
                }
            }
            .padding(.horizontal, 1)
        }
    }
}

#Preview {
    NameGenderInputView(
        studentName: .constant(""),
        studentGender: .constant("")
    )
}
