//
//  StatTagList.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct StatTagList: View {
    var tags: [[String: String]]

    var body: some View {
        WrappingHStack(horizontalSpacing: 8, verticalSpacing: 8) {
            ForEach(tags, id: \.self) { tag in
                // Safely unwrap dictionary values
                let label = tag["label"] ?? ""
                let stat = tag["stat"] ?? ""
                let match = tag["match"] ?? "N/A"
                StatTag(label: label, stat: stat, match: match)
            }
        }
    }
}
