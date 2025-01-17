//
//  HouseholdDetailsEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/29/24.
//

import SwiftUI

struct HouseholdDetailsEntryView: View {
    @Binding var householdIncome: String
    @Binding var financialAidNeed: String

    var body: some View {
        ScrollView {
            VStack(spacing: 36.0) {
                // Household Income Section
                VStack(alignment: .center, spacing: 24.0) {
                    VStack(alignment: .center, spacing: 8.0) {
                        Text("What's your family's income?")
                            .centeredTitleTextStyle()

                        Text(
                            "It's okay to not know exactly, just give your best estimation!"
                        )
                        .font(
                            Font.custom("Plus Jakarta Sans Regular", size: 16)
                        )
                        .foregroundColor(Color("Secondary"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 36)
                    }

                    SingleSelectBtns(
                        selectedOption: $householdIncome,
                        options: IncomeRange.allCases.map { $0.rawValue })
                }

                // Financial Aid Concern Section
                VStack(alignment: .leading, spacing: 24.0) {
                    Text("Are you worried about paying for college?")
                        .centeredTitleTextStyle()

                    SingleSelectBtns(
                        selectedOption: $financialAidNeed,
                        options: ["Yes", "No"])
                }
            }.padding(.horizontal, 1)
        }
    }
}

#Preview {
    HouseholdDetailsEntryView(
        householdIncome: .constant(""), financialAidNeed: .constant(""))
}
