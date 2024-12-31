//
//  HomeSettingInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct HomeSettingInputView: View {
    @Binding var studentPreferredDistance: String
    @Binding var studentPreferredSetting: String

    var body: some View {
        ScrollView {
            VStack(spacing: 36) {
                VStack(alignment: .center, spacing: 24) {
                    Text("How far from home do you want to go?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $studentPreferredDistance,
                        options: PreferredDistance.allCases.map { $0.rawValue })
                }
                VStack(alignment: .center, spacing: 24) {
                    Text("What type of setting are you looking for?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $studentPreferredSetting,
                        options: PreferredSetting.allCases.map { $0.rawValue })
                }
            }.padding(.horizontal, 1).padding(.bottom, 64)
        }
    }
}
