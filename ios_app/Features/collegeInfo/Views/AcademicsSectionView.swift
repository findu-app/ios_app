//
//  AcademicsSectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct AcademicsSectionView: View {
    var matchScore: String
    var degreesOffered: [[String: String]]
    var areasOfStudy: [[String: String]]
    var quickStats: [[String: String]]
    var link: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title section with match score
            SectionTitle(title: "Academics", matchScore: matchScore)

            // StatTag list for degrees offered
            StatSection(title: "Degrees Offered", tags: degreesOffered)

            // StatTag list for areas of study offered
            StatSection(title: "Areas of Study", tags: areasOfStudy)

            // Quick stats for tuition and costs
            StatSection(title: "Quick Stats", tags: quickStats)

            // Link to university website
            LinkBlock(
                title: "Link to University Website",
                url: link
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background(Color("SurfaceContainer"))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("Border"), lineWidth: 1)
        )
    }
}

#Preview {
    AcademicsSectionView(
        matchScore: "A+",
        degreesOffered: [
            ["label": "", "stat": "Associate's", "match": "N/A"],
            ["label": "", "stat": "Bachelor's", "match": "N/A"],
            ["label": "", "stat": "Master's", "match": "N/A"],
        ],
        areasOfStudy: [
            ["label": "", "stat": "Computer Science", "match": "N/A"],
            ["label": "", "stat": "Business", "match": "N/A"],
            ["label": "", "stat": "Art History", "match": "N/A"],
            ["label": "", "stat": "Art History", "match": "N/A"],
        ],
        quickStats: [
            [
                "label": "Student-Faculty Ratio", "stat": "15:1",
                "match": "High",
            ],
            ["label": "Graduation Rate", "stat": "85%", "match": "High"],
            ["label": "Retention Rate", "stat": "88%", "match": "Med"],
        ],
        link: "https://example.com"
    )
}
