//
//  QuickStats.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct QuickStats: View {
    var tags: [[String: String]]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Stats:")
                .font(
                    Font.custom("Plus Jakarta Sans Medium", size: 16))
            StatTagList(tags: tags)
        }
    }
}
