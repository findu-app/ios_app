//
//  EthnicityEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/8/25.
//

import SwiftUI

struct EthnicityEntryView: View {
    @Binding var ethnicity: String

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24.0) {
                Text("What is your race or ethnicity?")
                    .centeredTitleTextStyle()

                SingleSelectBtns(
                    selectedOption: $ethnicity,
                    options: Ethnicity.allCases.map { $0.rawValue }
                    )
            }.padding(.horizontal, 1)
        }
    }
}

#Preview {
    EthnicityEntryView(ethnicity: .constant(""))
}
