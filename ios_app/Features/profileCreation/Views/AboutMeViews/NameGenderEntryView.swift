//
//  NameGenderEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

struct NameGenderEntryView: View {
    @Binding var name: String
    @Binding var gender: String

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 36.0) {
                // Name Input
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What's your full name?").centeredTitleTextStyle()

                    StringTextField(
                        userInput: $name,
                        placeholder: "Enter your name"
                    )
                }

                // Gender Selection
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What's your gender?").centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $gender,
                        options: Gender.allCases.map { $0.rawValue }
                    )
                }
            }
            .padding(.horizontal, 1)
        }
    }
}

#Preview {
    NameGenderEntryView(
        name: .constant(""),
        gender: .constant("")
    )
}
