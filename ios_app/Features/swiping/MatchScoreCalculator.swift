//
//  MatchScoreCalculator.swift
//  ios_app
//
//  Created by Kenny Morales on 1/10/25.
//


import Foundation

/// Utility to compute match scores between a school and a student profile
struct MatchScoreCalculator {
    
    /// Computes the overall match score by calculating individual scores for each section
    /// - Parameters:
    ///   - school: The `School` object
    ///   - student: The `StudentInfo` object
    /// - Returns: A string representing the combined match grade
    static func computeMatchScore(for school: School, student: StudentInfo) -> String {
        var sectionScores: [String] = []
        
        print(school.name)

        // Costs Section
        let costScore = calculateCostMatch(for: school, student: student)
        sectionScores.append(costScore)
        print("Cost Match Score: \(costScore)")

        // Academics Section
        let academicsScore = calculateAcademicsMatch(for: school, student: student)
        sectionScores.append(academicsScore)
        print("Academics Match Score: \(academicsScore)")

        // Admissions Section
        let admissionsScore = calculateAdmissionsMatch(for: school, student: student)
        sectionScores.append(admissionsScore)
        print("Admissions Match Score: \(admissionsScore)")

        // Campus Section
        let campusScore = calculateCampusMatch(for: school, student: student)
        sectionScores.append(campusScore)
        print("Campus Match Score: \(campusScore)")

        // Outcomes Section
        let outcomesScore = calculateOutcomesMatch(for: school, student: student)
        sectionScores.append(outcomesScore)
        print("Outcomes Match Score: \(outcomesScore)")

        // Combine Section Scores into an Overall Grade
        let overallScore = calculateOverallGrade(from: sectionScores)
        print("Overall Match Score: \(overallScore)")
        print("")

        return overallScore
    }

    // MARK: - Individual Section Match Calculations

    private static func calculateCostMatch(for school: School, student: StudentInfo) -> String {
        guard let inStateTuition = school.inStateTuition, let outStateTuition = school.outStateTuition else {
            return "C"
        }
        // Example logic for matching costs (adjust as needed)
        let diff = abs(inStateTuition - outStateTuition)
        switch diff {
        case 0...5000:
            return "A"
        case 5001...10000:
            return "B"
        default:
            return "C"
        }
    }

    private static func calculateAcademicsMatch(for school: School, student: StudentInfo) -> String {
        guard let studentToFacultyRatio = school.studentToFacultyRatio else {
            return "C"
        }
        // Example logic for matching academics
        switch studentToFacultyRatio {
        case 0..<10:
            return "A"
        case 10..<20:
            return "B"
        default:
            return "C"
        }
    }

    private static func calculateAdmissionsMatch(for school: School, student: StudentInfo) -> String {
        guard let sACT = school.actScore, let stACT = student.actScore else {
            return "C"
        }
        // Matching based on ACT scores
        let diff = abs(Double(stACT) - Double(sACT))
        switch diff {
        case 0...2:
            return "A"
        case 3...5:
            return "B"
        default:
            return "C"
        }
    }

    private static func calculateCampusMatch(for school: School, student: StudentInfo) -> String {
        guard let size = school.size else {
            return "C"
        }
        // Example logic for campus size match
        switch size {
        case 0..<5000:
            return "A"
        case 5000..<15000:
            return "B"
        default:
            return "C"
        }
    }

    private static func calculateOutcomesMatch(for school: School, student: StudentInfo) -> String {
        guard let gradRate = school.fourYearGradRate else {
            return "C"
        }
        // Example logic for outcomes
        switch gradRate {
        case 0.75...1.0:
            return "A"
        case 0.5..<0.75:
            return "B"
        default:
            return "C"
        }
    }

    // MARK: - Combine Section Scores

    private static func calculateOverallGrade(from sectionScores: [String]) -> String {
        // Map grades to numeric values
        let gradeValues: [String: Float] = ["A+": 4.3, "A": 4.0, "B": 3.0, "C": 2.0, "D": 1.0]
        let numericScores = sectionScores.compactMap { gradeValues[$0] }
        let average = numericScores.reduce(0, +) / Float(numericScores.count)

        // Convert average back to grade
        switch average {
        case 4.0...:
            return "A"
        case 3.0..<4.0:
            return "B"
        case 2.0..<3.0:
            return "C"
        default:
            return "D"
        }
    }
}
