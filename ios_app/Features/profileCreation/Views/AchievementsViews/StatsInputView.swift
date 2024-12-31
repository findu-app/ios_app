//
//  StatsInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct StatsInputView: View {
    @Binding var studentGPA: String
    @Binding var studentACT: String
    @Binding var studentSAT: String
    @Binding var isACTNA: Bool
    @Binding var isSATNA: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 36) {
            // GPA Input
            VStack(alignment: .center, spacing: 24) {
                Text("What’s your GPA?").centeredTitleTextStyle()
                NumberField(userInput: $studentGPA, keyboardType: .decimalPad, maxLength: 4, placeholder: "e.g., 3.50")
            }
            
            // ACT Input with N/A Toggle
            VStack(alignment: .center, spacing: 12) {
                Text("What’s your ACT score?").centeredTitleTextStyle()
                NumberField(userInput: $studentACT, keyboardType: .numberPad, maxLength: 2, placeholder: "e.g., 24")
                    .disabled(isACTNA) // Disable input when N/A is selected
                
                Toggle(isOn: $isACTNA.animation()) {
                    Text("I haven't taken the test")
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                }
                .toggleStyle(SwitchToggleStyle(tint: Color("Primary")))
                .onChange(of: isACTNA) { isNA in
                    if isNA {
                        studentACT = "" // Clear ACT input when N/A is selected
                    }
                }
            }
            
            // SAT Input with N/A Toggle
            VStack(alignment: .center, spacing: 12) {
                Text("What’s your SAT score?").centeredTitleTextStyle()
                NumberField(userInput: $studentSAT, keyboardType: .numberPad, maxLength: 4, placeholder: "e.g., 1200")
                    .disabled(isSATNA) // Disable input when N/A is selected
                
                Toggle(isOn: $isSATNA.animation()) {
                    Text("I haven't taken the test")
                        .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                }
                .toggleStyle(SwitchToggleStyle(tint: Color("Primary")))
                .onChange(of: isSATNA) { isNA in
                    if isNA {
                        studentSAT = "" // Clear SAT input when N/A is selected
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    StatsInputView(
        studentGPA: .constant(""),
        studentACT: .constant(""),
        studentSAT: .constant(""),
        isACTNA: .constant(false),
        isSATNA: .constant(false)
    )
}
