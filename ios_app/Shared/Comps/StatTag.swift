//
//  StatTag.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct StatTag: View {
    var label: String
    var stat: String
    var match: String

    // Mapping for the ethnicities
    private let ethnicityColors: [String: Color] = [
        "white": Color("White"),
        "black": Color("Black"),
        "asian": Color("Asian"),
        "hispanic": Color("Hispanic"),
        "native american": Color("Native American"),
        "multi-racial": Color("Multi-Racial"),
        "other": Color.gray,
    ]

    private var backgroundColor: Color {
        if let ethnicityColor = ethnicityColors[label.lowercased()] {
            return ethnicityColor
        }

        switch match {
        case "High":
            return Color("High-BG")
        case "Medium":
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
        if ethnicityColors[label.lowercased()] != nil {
            return Color.white
        }

        switch match {
        case "Low":
            return Color("Low-FG")
        case "Medium":
            return Color("Med-FG")
        case "High":
            return Color("High-FG")
        case "N/A":
            return Color("NA-FG")
        default:
            return Color.gray.opacity(0.5)
        }
    }

    var body: some View {
        Text(label.isEmpty ? "\(stat)" : "\(label): \(stat)")
            .font(
                Font.custom("Plus Jakarta Sans Medium", size: 12)
            )
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
    }
}

#Preview {
    VStack(spacing: 8) {
        StatTag(label: "White", stat: "60%", match: "N/A")
        StatTag(label: "Black", stat: "30%", match: "N/A")
        StatTag(label: "Asian", stat: "10%", match: "N/A")
        StatTag(label: "Hispanic", stat: "25%", match: "N/A")
        StatTag(label: "Native American", stat: "5%", match: "N/A")
        StatTag(label: "Pacific Islander", stat: "2%", match: "N/A")
        StatTag(label: "Other", stat: "8%", match: "N/A")
        StatTag(label: "In-state Tuition", stat: "$10,000", match: "High")
    }
}
