//
//  CampusSectionView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct CampusSectionView: View {
    var matchScore: String
    var demographics: [[String: String]]
    var quickStats: [[String: String]]
    var link: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title section with match score
            SectionTitle(title: "Campus", matchScore: matchScore)
            
            // StatTag list for areas of study offered
            StatSection(title: "Demographics", tags: demographics)
            
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
    CampusSectionView(
        matchScore: "A+",
        demographics: [
            ["label": "White", "stat": "60%", "match": "N/A"],
            ["label": "Black", "stat": "30%", "match": "N/A"],
            ["label": "Asian", "stat": "10%", "match": "N/A"],
            ["label": "Hispanic", "stat": "25%", "match": "N/A"],
            ["label": "Native American", "stat": "5%", "match": "N/A"],
            ["label": "Multi-Racial", "stat": "2%", "match": "N/A"],
        ],
        quickStats: [
            ["label": "Student Size", "stat": "19,189", "match": "High"],
            ["label": "Setting", "stat": "Urban", "match": "Med"],
            ["label": "", "stat": "Christian university", "match": "High"],
            ["label": "", "stat": "Semester-Based", "match": "High"]
        ],
        link: "https://example.com"
    )
}

