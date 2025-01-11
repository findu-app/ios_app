//
//  StatTagList.swift
//  ios_app
//
//  Created by Kenny Morales on 1/8/25.
//

import SwiftUI
import WrappingHStack

struct StatTagList: View {
    var tags: [[String: String]]

    var body: some View {
        WrappingHStack(tags, id: \.self, spacing: .constant(8), lineSpacing: 8) { tag in
            let label = tag["label"] ?? ""
            let stat = tag["stat"] ?? ""
            let match = tag["match"] ?? "N/A"

            StatTag(label: label, stat: stat, match: match)
        }
    }
}
