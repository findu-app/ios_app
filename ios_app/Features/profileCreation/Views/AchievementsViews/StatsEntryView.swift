//
//  StatsEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct StatsEntryView: View {
    @Binding var gpa: String
    @Binding var actScore: String
    @Binding var satScore: String
    @Binding var isACTNA: Bool
    @Binding var isSATNA: Bool

    var body: some View {
        VStack(alignment: .center, spacing: 36) {
            // GPA Input
            VStack(alignment: .center, spacing: 24) {
                Text("What’s your GPA?").centeredTitleTextStyle()
                NumberTextField(
                    userInput: $gpa, keyboardType: .decimalPad, maxLength: 4,
                    placeholder: "e.g., 3.50")
            }

            // ACT Input with N/A Toggle
            VStack(alignment: .center, spacing: 12) {
                Text("What’s your ACT score?").centeredTitleTextStyle()
                NumberTextField(
                    userInput: $actScore, keyboardType: .numberPad,
                    maxLength: 2, placeholder: "e.g., 24"
                )
                .disabled(isACTNA)  // Disable input when N/A is selected

                Toggle(isOn: $isACTNA.animation()) {
                    Text("I haven't taken the test")
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                }
                .toggleStyle(SwitchToggleStyle(tint: Color("Primary")))
                .onChange(of: isACTNA) { isNA in
                    if isNA {
                        actScore = ""  // Clear ACT input when N/A is selected
                    }
                }
            }

            // SAT Input with N/A Toggle
            VStack(alignment: .center, spacing: 12) {
                Text("What’s your SAT score?").centeredTitleTextStyle()
                NumberTextField(
                    userInput: $satScore, keyboardType: .numberPad,
                    maxLength: 4, placeholder: "e.g., 1200"
                )
                .disabled(isSATNA)  // Disable input when N/A is selected

                Toggle(isOn: $isSATNA.animation()) {
                    Text("I haven't taken the test")
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                }
                .toggleStyle(SwitchToggleStyle(tint: Color("Primary")))
                .onChange(of: isSATNA) { isNA in
                    if isNA {
                        satScore = ""  // Clear SAT input when N/A is selected
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    StatsEntryView(
        gpa: .constant(""),
        actScore: .constant(""),
        satScore: .constant(""),
        isACTNA: .constant(false),
        isSATNA: .constant(false)
    )
}
