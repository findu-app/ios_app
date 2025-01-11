//
//  CollegeInfoView.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct CollegeInfoView: View {
    var school: School
    var studentMatchScore: StudentSchoolMatch

    var body: some View {

        
        ScrollView {
            VStack(spacing: 24) {
                CollegeInfoTitle(
                    school: school.name ?? "Unknown School",
                    cityState: "\(school.city ?? "Unknown City"), \(school.state ?? "Unknown State")"
                )
                
                CostSectionView(
                    matchScore: studentMatchScore.costScore,
                    fourYearDebt: "\(school.averageDebt ?? 0)",
                    averageCost: "\(school.coaAcademicYear ?? 0)",
                    quickStats: [
                        [
                            "label": "In-state Tuition",
                            "stat": "\(school.inStateTuition ?? 0)",
                            "match": studentMatchScore.inStateTutionMatch
                        ],
                        [
                            "label": "Out-of-state Tuition",
                            "stat": "\(school.outStateTuition ?? 0)",
                            "match": studentMatchScore.outStateTutionMatch
                        ],
                    ],
                    link: "https://example.com"
                )
                
                AcademicsSectionView(
                    matchScore: studentMatchScore.academicScore,
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
                        [
                            "label": "Student-Faculty Ratio",
                            "stat": "\(school.studentToFacultyRatio ?? 0)",
                            "match": studentMatchScore.studentToFacultyRatioMatch
                        ]
                    ],
                    link: "https://example.com"
                )
                
                AdmissionsSectionView(
                    matchScore: studentMatchScore.admissionScore,
                    chancesOfIn: "Very High (Safety)",
                    quickStats: [
                        [
                            "label": "Admissions Rate",
                            "stat": "\(school.admissionsRate ?? 0)%",
                            "match": studentMatchScore.admissionsRateMatch
                        ],
                        [
                            "label": "Average SAT",
                            "stat": "\(school.satScore ?? 0)",
                            "match": studentMatchScore.satScoreMatch
                        ],
                        [
                            "label": "Average ACT",
                            "stat": "\(school.actScore ?? 0)",
                            "match": studentMatchScore.actScoreMatch
                        ]
                    ],
                    link: "https://example.com"
                )
                
                CampusSectionView(
                    matchScore: studentMatchScore.campusScore,
                    demographics: [
                        ["label": "White", "stat": "60%", "match": "N/A"],
                        ["label": "Black", "stat": "30%", "match": "N/A"],
                        ["label": "Asian", "stat": "10%", "match": "N/A"]
                    ],
                    quickStats: [
                        [
                            "label": "Setting",
                            "stat": "\(school.localeDescription)",
                            "match": studentMatchScore.localeMatch
                        ]
                    ],
                    link: "https://example.com"
                )
                
                OutcomesSectionView(
                    matchScore: studentMatchScore.outcomesScore,
                    salaryAfterCollege: "$60,000",
                    studentsWhoReturn: "88%",
                    quickStats: [
                        [
                            "label": "Graduation Rate",
                            "stat": "\((school.fourYearGradRate ?? 0.0) * 100)%",
                            "match": studentMatchScore.fourYearGradRateMatch
                        ],
                        [
                            "label": "Percent Earning More Than HS Grad",
                            "stat": "\((school.percentEarningMoreThanHSGrad ?? 0.0) * 100)%",
                            "match": studentMatchScore.percentEarningMoreThanHSGradMatch
                        ]
                    ],
                    link: "https://example.com"
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 40)
        }
        .background(Color("Surface"))
    }
}
