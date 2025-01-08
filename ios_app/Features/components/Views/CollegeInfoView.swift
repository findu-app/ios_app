//
//  CollegeInfoView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct CollegeInfoView: View {
    var body: some View {
        ScrollView {
            VStack (spacing: 24){
                CollegeInfoTitle()
                
                CostSectionView(
                    matchScore: "A+",
                    fourYearDebt: "$22,000",
                    averageCost: "$15,000",
                    quickStats: [
                        [
                            "label": "In-state Tuition", "stat": "$10,000",
                            "match": "High",
                        ],
                        [
                            "label": "Out-of-state Tuition", "stat": "$25,000",
                            "match": "Med",
                        ],
                    ],
                    link: "https://example.com"
                )
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
                        ["label": "", "stat": "Art History", "match": "N/A"]
                    ],
                    quickStats: [
                        ["label": "Student-Faculty Ratio", "stat": "15:1", "match": "High"],
                        ["label": "Graduation Rate", "stat": "85%", "match": "High"],
                        ["label": "Retention Rate", "stat": "88%", "match": "Med"]
                    ],
                    link: "https://example.com"
                )
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
            .padding(.horizontal, 16)

        }
        .background(Color("Surface"))
    }
}

#Preview {
    CollegeInfoView()
}
