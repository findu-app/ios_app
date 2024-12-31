//
//  ProgramsEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct ProgramsEntryView: View {
    @Binding var specialPrograms: String
    @Binding var greekLifeInterest: String
    @Binding var researchInterest: String

    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                VStack(alignment: .center, spacing: 24) {
                    Text("Are you interested in advanced or honors programs?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $specialPrograms,
                        options: ["Yes", "No"])
                }
                VStack(alignment: .center, spacing: 24) {
                    Text("Greek Life?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $greekLifeInterest,
                        options: ["Yes", "No"])
                }
                VStack(alignment: .center, spacing: 24) {
                    Text("Research?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $researchInterest,
                        options: ["Yes", "No"])
                }
            }.padding(.horizontal, 1).padding(.bottom, 64)
        }
    }
}
