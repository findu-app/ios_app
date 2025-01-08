//
//  SectionBlock.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct SectionBlock: View {
    var title: String
    var statistic: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(Font.custom("Plus Jakarta Sans Regular", size: 14))
            Text(statistic)
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 18))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(Color("Surface"))
        .cornerRadius(10)
    }
}

#Preview {
    SectionBlock(title: "Title", statistic: "Statistic")
}
