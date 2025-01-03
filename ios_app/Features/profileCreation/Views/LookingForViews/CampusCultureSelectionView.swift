//
//  CampusCultureSelectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct CampusCultureSelectionView: View {
    @Binding var campusCulturePreferences: [String]

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("What type of campus culture are you looking for?")
                .centeredTitleTextStyle()

            Text("Select at least 3 options")
                .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                .foregroundColor(Color("Secondary"))
                .multilineTextAlignment(.center)

            MultiSelectBtns(
                selectedOptions: $campusCulturePreferences,
                options: CampusCulture.allCases.map { $0.rawValue })
        }
    }
}
