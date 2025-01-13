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
    @Binding var selectedOption: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.bottom)
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                }) {
                    HStack {
                        Text(option)
                        Spacer()
                        if selectedOption == option {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
        }
    }
}
