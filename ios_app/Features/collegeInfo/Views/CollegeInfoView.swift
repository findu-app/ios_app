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
                    cityState:
                        "\(school.city ?? "Unknown City"), \(school.state ?? "Unknown State")",
                    matchScore: studentMatchScore.matchScore
                )

                CostSectionView(
                    matchScore: studentMatchScore.costScore,
                    fourYearDebt:
                        "\(StatFormatter.formatToDollarString(school.averageDebt))",
                    averageCost:
                        "\(StatFormatter.formatToDollarString(Float(school.coaAcademicYear ?? 0)))",
                    quickStats: [
                        [
                            "label": "In-state Tuition",
                            "stat":
                                "\(StatFormatter.formatToDollarString(school.inStateTuition))",
                            "match": studentMatchScore.inStateTutionMatch,
                        ],
                        [
                            "label": "Net Price",
                            "stat": StatFormatter.formatNetPrice(
                                publicPrice: school.averageNetPricePublic,
                                privatePrice: school.averageNetPricePrivate
                            ),
                            "match": StatFormatter.formatNetPriceMatch(
                                publicMatch: studentMatchScore
                                    .averageNetPricePublic,
                                privateMatch: studentMatchScore
                                    .averageNetPricePrivate
                            ),
                        ],
                        [
                            "label": "Out-of-state Tuition",
                            "stat":
                                "\(StatFormatter.formatToDollarString(school.outStateTuition))",
                            "match": studentMatchScore.outStateTutionMatch,
                        ],
                        [
                            "label": "Avg Aid",
                            "stat":
                                "\(StatFormatter.formatToDollarString(Float(school.averageFinancialAid ?? 0)))",
                            "match": studentMatchScore.averageNetPricePublic
                                ?? studentMatchScore.averageNetPricePrivate
                                ?? "N/A",
                        ],
                    ],
                    link: StatFormatter.formatURL(school.schoolUrl)
                )

                AcademicsSectionView(
                    matchScore: studentMatchScore.academicScore,
                    degreesOffered: [
                        ["label": "", "stat": "Associate's", "match": "N/A"],
                        ["label": "", "stat": "Bachelor's", "match": "N/A"],
                        ["label": "", "stat": "Master's", "match": "N/A"],
                    ],
                    areasOfStudy: [
                        [
                            "label": "", "stat": "Computer Science",
                            "match": "N/A",
                        ],
                        ["label": "", "stat": "Business", "match": "N/A"],
                        ["label": "", "stat": "Art History", "match": "N/A"],
                    ],
                    quickStats: [
                        [
                            "label": "Student-Faculty Ratio",
                            "stat":
                                "\(StatFormatter.formatStudentFacultyRatio(school.studentToFacultyRatio))",
                            "match": studentMatchScore
                                .studentToFacultyRatioMatch,
                        ],
                        [
                            "label": "School Type",
                            "stat": school.carnegieDescription,
                            "match": "N/A",
                        ],
                    ],
                    link: StatFormatter.formatURL(school.schoolUrl)
                )

                AdmissionsSectionView(
                    matchScore: studentMatchScore.admissionScore,
                    chancesOfIn: studentMatchScore.chancesOfAcceptanceMatch,
                    quickStats: [
                        [
                            "label": "Admissions Rate",
                            "stat": StatFormatter.formatAdmissionsRate(
                                school.admissionsRate),
                            "match": studentMatchScore.admissionsRateMatch,
                        ],
                        [
                            "label": "Average SAT",
                            "stat": StatFormatter.formatSATScore(
                                school.satScore),
                            "match": studentMatchScore.satScoreMatch,
                        ],
                        [
                            "label": "Average ACT",
                            "stat": StatFormatter.formatACTScore(
                                school.actScore),
                            "match": studentMatchScore.actScoreMatch,
                        ],
                    ],
                    link: StatFormatter.formatURL(school.schoolUrl)
                )

                CampusSectionView(
                    matchScore: studentMatchScore.campusScore,
                    demographics: [
                        [
                            "label": "White",
                            "stat": StatFormatter.formatPercent(school.white),
                            "match": "N/A",
                        ],
                        [
                            "label": "Black",
                            "stat": StatFormatter.formatPercent(school.black),
                            "match": "N/A",
                        ],
                        [
                            "label": "Asian",
                            "stat": StatFormatter.formatPercent(school.asian),
                            "match": "N/A",
                        ],
                        [
                            "label": "Hispanic",
                            "stat": StatFormatter.formatPercent(
                                school.hispanic), "match": "N/A",
                        ],
                        [
                            "label": "Native American",
                            "stat": StatFormatter.formatPercent(school.aian),
                            "match": "N/A",
                        ],
                        [
                            "label": "Multi-Racial",
                            "stat": StatFormatter.formatPercent(
                                school.twoOrMore), "match": "N/A",
                        ],
                    ]
                    .filter {
                        let stat =
                            Float(
                                $0["stat"]?.replacingOccurrences(
                                    of: "%", with: "") ?? "0") ?? 0
                        return stat > 0
                    }
                    .sorted {
                        let stat1 =
                            Float(
                                $0["stat"]?.replacingOccurrences(
                                    of: "%", with: "") ?? "0") ?? 0
                        let stat2 =
                            Float(
                                $1["stat"]?.replacingOccurrences(
                                    of: "%", with: "") ?? "0") ?? 0
                        return stat1 > stat2
                    },
                    quickStats: [
                        [
                            "label": "",
                            "stat": school.ownershipDescription,
                            "match": "N/A",
                        ],
                        [
                            "label": "Setting",
                            "stat": "\(school.localeDescription)",
                            "match": studentMatchScore.localeMatch,
                        ],
                    ],
                    link: StatFormatter.formatURL(school.schoolUrl)
                )

                OutcomesSectionView(
                    matchScore: studentMatchScore.outcomesScore,
                    employmentRate: StatFormatter.formatEmploymentRate(
                        school.calculatedEmploymentRate),
                    studentsWhoReturn: StatFormatter.formatPercent(
                        school.fourYearRetentionRate),
                    quickStats: [
                        [
                            "label": "Graduation Rate",
                            "stat": StatFormatter.formatPercent(
                                school.fourYearGradRate),
                            "match": studentMatchScore.fourYearGradRateMatch,
                        ],
                        [
                            "label": "Percent Earning More Than HS Grad",
                            "stat": StatFormatter.formatPercent(
                                school.percentEarningMoreThanHSGrad),
                            "match": studentMatchScore
                                .percentEarningMoreThanHSGradMatch,
                        ],
                    ],
                    link: StatFormatter.formatURL(school.schoolUrl)
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 40)
        }
        .background(Color("Surface"))
    }
}
