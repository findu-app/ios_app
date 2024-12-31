//
//  ClassRankInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct ClassRankInputView: View {
    @Binding var studentClassRank: String
    @Binding var studentAPIB: String

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 36.0) {
                // Gender Selection
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What’s your class rank?").centeredTitleTextStyle()
                    
                    SingleSelectBtns(
                        selectedOption: $studentClassRank,
                        options: ClassRank.allCases.map { $0.rawValue }
                    )
                }
                // Name Input
                VStack(alignment: .center, spacing: 24.0) {
                    Text("How many AP/IB classes have you taken?").centeredTitleTextStyle()
                    
                    NumberField(userInput: $studentAPIB, keyboardType: .numberPad, maxLength: 2, placeholder: "0")
                }
            }
            .padding(.horizontal, 1)
            .padding(.bottom, 64)
        }
    }
}

#Preview {
    ClassRankInputView(
        studentClassRank: .constant(""),
        studentAPIB: .constant("")
    )
}
