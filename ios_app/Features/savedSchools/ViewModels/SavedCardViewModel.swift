//
//  SavedCardViewModel.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/14/25.
//


import Foundation
import Supabase

@MainActor
class SavedCardViewModel: Identifiable, ObservableObject {
    @Published var tags: [[String: String]] = []
    @Published var matchScore: String = "N/A"
    @Published var studentMatch: StudentSchoolMatch?
    @Published var showSheet: Bool = false

    let school: School
    let globalStudentState: GlobalStudentDataState
    
    init(school: School, globalStudentState: GlobalStudentDataState) {
        self.school = school
        self.globalStudentState = globalStudentState
    }

    /// Example of computing the match locally
    func fetchMatchScore() async {
        guard let studentProfile = globalStudentState.studentInfo else {
            print("No student profile available.")
            return
        }

        // Compute the full match object
        let computedMatch = MatchScoreCalculator.computeMatchScore(
            for: school,
            student: studentProfile
        )
        self.studentMatch = computedMatch
        self.matchScore = computedMatch.matchScore
    }

    /// Build your chosen tags from the match details
    func buildTags() {
        guard let match = studentMatch else {
            print("No StudentSchoolMatch available yet.")
            return
        }

        var newTags: [[String: String]] = []

        // Conditionally include Avg Aid
        print("HI \(school.averageFinancialAid)")
        if let avgAidValue = school.averageFinancialAid, avgAidValue != 0 {
            let avgAidStat = StatFormatter.formatToDollarString(avgAidValue)
            newTags.append([
                "label": "Avg Aid",
                "stat": avgAidStat,
                "match": match.financialAidMatch
            ])
        }

        // Always include "Average ACT"
        let actStat = StatFormatter.formatACTScore(school.actScore)
        newTags.append([
            "label": "Average ACT",
            "stat": actStat,
            "match": match.actScoreMatch
        ])

        // Always include "Student Size"
        let sizeStat = "\(school.size ?? 0)"
        newTags.append([
            "label": "Student Size",
            "stat": sizeStat,
            "match": match.sizeMatch
        ])

        // Always include "Avg Tuition"
        let tuitionStat = StatFormatter.formatToDollarString(school.inStateTuition)
        newTags.append([
            "label": "Avg Tuition",
            "stat": tuitionStat,
            "match": match.inStateTutionMatch
        ])

        tags = newTags
    }
}
