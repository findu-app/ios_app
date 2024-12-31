//
//  ProgramsInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct ProgramsInputView: View {
    @Binding var studentSpecialPrograms: String
    @Binding var studentGreekLife: String
    @Binding var studentResearch: String

    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                VStack(alignment: .center, spacing: 24) {
                    Text("Are you interested in advanced or honors programs?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $studentSpecialPrograms,
                        options: ["Yes", "No"])
                }
                VStack(alignment: .center, spacing: 24) {
                    Text("Greek Life?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $studentGreekLife,
                        options: ["Yes", "No"])
                }
                VStack(alignment: .center, spacing: 24) {
                    Text("Research?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $studentResearch,
                        options: ["Yes", "No"])
                }
            }.padding(.horizontal, 1).padding(.bottom, 64)
        }
    }
}
