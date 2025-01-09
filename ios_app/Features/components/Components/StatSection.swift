//  StatSection.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.

import SwiftUI
import WrappingHStack

struct StatSection: View {
    var title: String
    var tags: [[String: String]]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                .foregroundColor(Color("OnSurface"))

            StatTagList(tags: tags)
        }
    }
}

#Preview {
    StatSection(
        title: "Title",
        tags: [
            ["label": "", "stat": "Computer Science", "match": "N/A"],
            ["label": "", "stat": "Business", "match": "N/A"],
            ["label": "", "stat": "Art History", "match": "N/A"],
        ])
}
