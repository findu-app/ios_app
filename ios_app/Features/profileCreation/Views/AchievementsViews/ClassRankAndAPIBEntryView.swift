//
//  ClassRankAndAPIBEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct ClassRankAndAPIBEntryView: View {
    @Binding var classRank: String
    @Binding var numAPClass: String

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 36.0) {
                // Gender Selection
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What’s your class rank?").centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $classRank,
                        options: ClassRank.allCases.map { $0.rawValue }
                    )
                }
                // Name Input
                VStack(alignment: .center, spacing: 24.0) {
                    Text("How many AP/IB classes have you taken?")
                        .centeredTitleTextStyle()

                    NumberTextField(
                        userInput: $numAPClass, keyboardType: .numberPad,
                        maxLength: 2, placeholder: "0")
                }
            }
            .padding(.horizontal, 1)
            .padding(.bottom, 64)
        }
    }
}

#Preview {
    ClassRankAndAPIBEntryView(
        classRank: .constant(""),
        numAPClass: .constant("")
    )
}
