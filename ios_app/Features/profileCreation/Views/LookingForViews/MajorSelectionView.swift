//
//  MajorSelectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct MajorSelectionView: View {
    @Binding var majors: [String]

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("What majors do you find interesting?")
                .centeredTitleTextStyle()

            Text("Select at least 3 options")
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .foregroundColor(Color("Secondary"))
                .multilineTextAlignment(.center)

            MultiSelectBtns(
                selectedOptions: $majors,
                options: Major.allCases.map { $0.rawValue })
        }
    }
}
