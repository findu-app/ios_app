//
//  AdmissionsSectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct AdmissionsSectionView: View {
    var matchScore: String
    var chancesOfIn: String
    var quickStats: [[String: String]]
    var link: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title section with match score
            SectionTitle(title: "Admissions", matchScore: matchScore)
            
            // Your chances of getting in
            SectionBlock(
                title: "Your chances of getting in",
                statistic: chancesOfIn,
                match: determineMatch(for: chancesOfIn)
            )
            
            // Quick stats for admissions
            StatSection(
                title: "Quick Stats",
                tags: quickStats
            )
            
            // Link to university website
            LinkBlock(
                title: "Visit University Website",
                url: link
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(Color("SurfaceContainer"))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("Border"), lineWidth: 1)
        )
    }
    
    /// Determines the match value dynamically based on the chances of getting in.
    private func determineMatch(for chances: String) -> String {
        let lowercasedChances = chances.lowercased()
        if lowercasedChances.contains("high") {
            return "High"
        } else if lowercasedChances.contains("medium") || lowercasedChances.contains("med") {
            return "Med"
        } else if lowercasedChances.contains("low") {
            return "Low"
        } else {
            return "N/A"
        }
    }
}

#Preview {
    AdmissionsSectionView(
        matchScore: "A+",
        chancesOfIn: "Very High (Safety)",
        quickStats: [
            ["label": "Student Size", "stat": "19,189", "match": "High"],
            ["label": "Setting", "stat": "Urban", "match": "Med"],
            ["label": "", "stat": "Christian university", "match": "High"],
            ["label": "", "stat": "Semester-Based", "match": "High"]
        ],
        link: "https://example.com"
    )
}
