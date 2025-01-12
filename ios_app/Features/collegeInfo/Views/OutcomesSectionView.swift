//
//  OutcomesSectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct OutcomesSectionView: View {
    var matchScore: String
    var employmentRate: String
    var studentsWhoReturn: String
    var quickStats: [[String: String]]
    var link: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title section with match score
            SectionTitle(title: "Outcomes", matchScore: matchScore)

            // Employment rate and student retention blocks
            VStack(alignment: .leading, spacing: 8) {
                SectionBlock(
                    title: "Employment Rate",
                    statistic: employmentRate,
                    match: determineMatch(for: employmentRate)
                )
                SectionBlock(
                    title: "Students Who Return After Year One",
                    statistic: studentsWhoReturn,
                    match: determineMatchForReturningStudents(
                        for: studentsWhoReturn
                    )
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

    /// Determines the match value dynamically based on the employment rate.
    private func determineMatch(for employmentRate: String) -> String {
        // Convert the input to lowercase and remove the "%" symbol
        let cleanedRate = employmentRate
            .replacingOccurrences(of: "%", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        // Ensure the cleaned rate can be converted to a Float
        guard let rateValue = Float(cleanedRate) else { return "N/A" }

        // Classify based on thresholds
        switch rateValue {
        case 85...: // 85% and above
            return "High"
        case 65..<85: // Between 65% and 85%
            return "Medium"
        case ..<65: // Below 65%
            return "Low"
        default:
            return "N/A"
        }
    }

    /// Determines the match value dynamically for students who return after year one.
    private func determineMatchForReturningStudents(for retentionRate: String) -> String {
        // Clean the input by removing "%" and trimming whitespace
        let cleanedRate = retentionRate
            .replacingOccurrences(of: "%", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()

        // Ensure the cleaned rate can be converted to a Float
        guard let rateValue = Float(cleanedRate) else { return "N/A" }
        print(rateValue)

        // Classify based on thresholds
        switch rateValue {
        case 80...: // 80% and above
            return "High"
        case 40..<70: // Between 60% and 80%
            return "Medium"
        case ..<40: // Below 60%
            return "Low"
        default:
            return "N/A"
        }
    }
}


#Preview {
    OutcomesSectionView(
        matchScore: "A+",
        employmentRate: "85%",
        studentsWhoReturn: "78%",
        quickStats: [
            ["label": "In-state Tuition", "stat": "$10,000", "match": "High"],
            ["label": "Out-of-state Tuition", "stat": "$25,000", "match": "Med"]
        ],
        link: "https://example.com"
    )
}

