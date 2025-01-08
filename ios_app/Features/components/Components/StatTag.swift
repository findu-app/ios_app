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
        case "Low":
            return Color("Low-FG")
        case "Med":
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
        StatTag(label: "In-state Tuition", stat: "$10,000", match: "High")
        StatTag(label: "Out-of-state Tuition", stat: "$25,000", match: "Med")
        StatTag(label: "Scholarship Opportunities", stat: "Available", match: "Low")
        StatTag(label: "Financial Aid", stat: "Limited", match: "N/A")
        StatTag(label: "", stat: "No Data", match: "N/A")
    }
}
