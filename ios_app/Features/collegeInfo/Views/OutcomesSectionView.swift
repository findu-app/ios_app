//
//  OutcomesSectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct OutcomesSectionView: View {
    var matchScore: String
    var salaryAfterCollege: String
    var studentsWhoReturn: String
    var quickStats: [[String: String]]
    var link: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title section with match score
            SectionTitle(title: "Outcomes", matchScore: matchScore)

            // Debt and cost blocks
            VStack(alignment: .leading, spacing: 8) {
                SectionBlock(
                    title: "Average salary out of college",
                    statistic: salaryAfterCollege,
                    match: "N/A"
                )
                SectionBlock(
                    title: "Student’s who return after year one",
                    statistic: studentsWhoReturn,
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
    OutcomesSectionView(
        matchScore: "A+",
        salaryAfterCollege: "$60,000",
        studentsWhoReturn: "88%",
        quickStats: [
            ["label": "In-state Tuition", "stat": "$10,000", "match": "High"],
            ["label": "Out-of-state Tuition", "stat": "$25,000", "match": "Med"]
        ],
        link: "https://example.com"
    )
}
