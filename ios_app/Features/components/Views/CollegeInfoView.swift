//
//  CollegeInfoView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct CollegeInfoView: View {
    var body: some View {
        VStack {
            CostSectionView(
                matchScore: "A+",
                fourYearDebt: "$22,000",
                averageCost: "$15,000",
                quickStats: [
                    ["label": "In-state Tuition", "stat": "$10,000", "match": "High"],
                    ["label": "Out-of-state Tuition", "stat": "$25,000", "match": "Med"]
                ],
                link: "https://example.com"
            )

        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 16)
        .background(Color("Surface"))
    }
}

#Preview {
    CollegeInfoView()
}
