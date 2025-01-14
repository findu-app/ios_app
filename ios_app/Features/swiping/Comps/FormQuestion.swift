//
//  QuestionView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/13/25.
//

import SwiftUI

struct FormQuestion: View {
    var title: String
    var options: [String]
    @Binding var selectedOptions: [String]

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(title)
                .font(.custom("Plus Jakarta Sans SemiBold", size: 20))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(.bottom, 8)

            VStack(spacing: 12) {
                ForEach(options, id: \.self) { option in
                    FormButton(
                        title: option,
                        // A button is considered "selected" if the array contains this option
                        isSelected: selectedOptions.contains(option),
                        action: {
                            if selectedOptions.contains(option) {
                                // remove the option
                                selectedOptions.removeAll { $0 == option }
                            } else {
                                // add the option
                                selectedOptions.append(option)
                            }
                        }
                    )
                }
            }.padding(.bottom, 16)
        }
    }
}

#Preview {
    @State var selectedOptions = ["Costs"]
    FormQuestion(
        title: "What did you like the most about this school?",
        options: [
            "Costs", "Academics", "Admissions", "Campus", "Financial Aid",
            "Special Programs", "Career",
        ],
        selectedOptions: $selectedOptions
    )
}
