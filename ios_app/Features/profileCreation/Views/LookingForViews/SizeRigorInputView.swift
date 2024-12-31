//
//  SizeRigorInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct SizeRigorInputView: View {
    @Binding var studentPreferredSize: String
    @Binding var studentRigor: String

    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                VStack(alignment: .center, spacing: 24) {
                    Text("How big of a school do you want to go to?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $studentPreferredSize,
                        options: PreferredSize.allCases.map { $0.rawValue })
                }
                VStack(alignment: .center, spacing: 24) {
                    Text("How competitive of a school are you looking for?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $studentRigor,
                        options: Rigor.allCases.map { $0.rawValue })
                }
            }.padding(.horizontal, 1).padding(.bottom, 64)
        }
    }
}
