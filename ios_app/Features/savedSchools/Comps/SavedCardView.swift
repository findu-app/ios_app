//
//  SavedCardView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/13/25.
//


import SwiftUI

struct SavedCardView: View {
    let school: School
    let rating: String?  // e.g. "A+", or nil if no rating

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // School Title & Rating
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(school.name ?? "Unknown School")
                        .font(.headline)
                        .lineLimit(2)
                    
                    Text("\(school.city ?? ""), \(school.state ?? "")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                if let rating = rating {
                    Text(rating)
                        .font(.title2)
                        .foregroundColor(.green) // Or whichever color you prefer
                }
            }

            // Tags, rendered by StatTagList
            StatTagList(tags: buildTags())
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        )
    }

    /// Build an array of dictionaries for `StatTagList`
    private func buildTags() -> [[String: String]] {
        var tags: [[String: String]] = []

        // Conditionally include "Avg Aid"
        if let avgAidValue = school.averageFinancialAid, avgAidValue != 0 {
            let avgAid = StatFormatter.formatToDollarString(avgAidValue)
            tags.append(["label": "Avg Aid", "stat": avgAid, "match": "High"])
        }

        // Always include "Average ACT"
        let act = StatFormatter.formatACTScore(school.actScore)
        tags.append(["label": "Average ACT", "stat": act, "match": "Medium"])

        // Always include "Student Size"
        let size = "\(school.size)"
        tags.append(["label": "Student Size", "stat": size, "match": "Low"])

        // Always include "Avg Tuition"
        let tuition = StatFormatter.formatToDollarString(school.inStateTuition)
        tags.append(["label": "Avg Tuition", "stat": tuition, "match": "High"])

        return tags
    }
}
