//
//  GraduationYearEntryView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/29/24.
//

import SwiftUI

struct GraduationYearEntryView: View {
    @Binding var graduationYear: String

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24.0) {
                Text("What year do you graduate from high school?")
                    .centeredTitleTextStyle()

                SingleSelectBtns(
                    selectedOption: $graduationYear,
                    options: ["2025", "2026", "2027", "2028"])
            }.padding(.horizontal, 1)
        }
    }
}

#Preview {
    GraduationYearEntryView(graduationYear: .constant(""))
}
