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
    var match: String  // New property for match status

    private var backgroundColor: Color {
        switch match {
        case "High":
            return Color("High-BG")
        case "Med":
            return Color("Med-BG")
        case "Low":
            return Color("Low-BG")
        case "N/A":
            return Color("NA-BG")
        default:
            return Color.gray.opacity(0.5)
        }
    }

    private var foregroundColor: Color {
        switch match {
        case "High":
            return Color("High-FG")
        case "Med":
            return Color("Med-FG")
        case "Low":
            return Color("Low-FG")
        case "N/A":
            return Color("NA-FG")
        default:
            return Color.gray
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(Font.custom("Plus Jakarta Sans Regular", size: 14))
                .foregroundColor(foregroundColor)
            Text(statistic)
                .font(Font.custom("Plus Jakarta Sans SemiBold", size: 18))
                .foregroundColor(foregroundColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(10)
    }
}

#Preview {
    SectionBlock(title: "Title", statistic: "Statistic", match: "N/A")
}
