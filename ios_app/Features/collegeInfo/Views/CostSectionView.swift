//
//  CostSectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct CostSectionView: View {
    var matchScore: String
    var fourYearDebt: String
    var averageCost: String
    var quickStats: [[String: String]]
    var link: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title section with match score
            SectionTitle(title: "Cost", matchScore: matchScore)

            // Debt and cost blocks
            VStack(alignment: .leading, spacing: 8) {
                SectionBlock(
                    title: "Average debt after 4 years",
                    statistic: fourYearDebt,
                    match: "N/A"
                )
                SectionBlock(
                    title: "Average cost per year:",
                    statistic: averageCost,
                    match: "N/A"
                )
            }

            // Quick stats for tuition and costs
            StatSection(title: "Quick Stats", tags: quickStats)

            // Link to university website
            LinkBlock(
                title: "Link to University Website",
                url: link
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(Color("SurfaceContainer"))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("Border"), lineWidth: 1)
        )
    }
}

#Preview {
    CostSectionView(
        matchScore: "A+",
        fourYearDebt: "$22,000",
        averageCost: "$15,000",
        quickStats: [
            ["label": "In-state Tuition", "stat": "$10,000", "match": "High"],
            [
                "label": "Out-of-state Tuition", "stat": "$25,000",
                "match": "Med",
            ],
        ],
        link: "https://example.com"
    )
}
