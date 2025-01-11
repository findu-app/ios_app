// MatchScoreCalculator.swift
// ios_app
//
// Created by Kenny Morales on 1/10/25.

import Foundation

/// Utility to compute match scores between a school and a student profile.
struct MatchScoreCalculator {

    /// Computes the overall match score by calculating individual section scores.
    /// - Parameters:
    ///   - school: The `School` object.
    ///   - student: The `StudentInfo` object.
    /// - Returns: A `StudentSchoolMatch` object containing all match details.
    static func computeMatchScore(for school: School, student: StudentInfo)
        -> StudentSchoolMatch
    {
        // Calculate detailed matches for each section
        let costDetails = calculateCostDetails(for: school)
        let admissionsDetails = calculateAdmissionsDetails(
            for: school, student: student)
        let academicDetails = calculateAcademicsDetails(for: school)
        let campusDetails = calculateCampusDetails(for: school)
        let outcomesDetails = calculateOutcomesDetails(for: school)

        let costScore = calculateOverallGrade(from: [
            costDetails.averageDebt4YearMatch,
            costDetails.averageNetPricePublic,
            costDetails.averageNetPricePrivate,
            costDetails.inStateTuitionMatch,
            costDetails.outStateTuitionMatch,
            costDetails.coaAcademicYearMatch,
            costDetails.coaAcademicYearMatch,
        ])

        let admissionScore = calculateOverallGrade(from: [
            admissionsDetails.actScoreMatch,
            admissionsDetails.satScoreMatch,
            admissionsDetails.admissionsRateMatch,
        ])

        let academicScore = calculateOverallGrade(from: [
            academicDetails
        ])

        let campusScore = calculateOverallGrade(from: [
            campusDetails
        ])

        let outcomesScore = calculateOverallGrade(from: [
            outcomesDetails.gradRateMatch,
            outcomesDetails.percentEarningMoreThanHSGradMatch,
            outcomesDetails.workingNotEnrolledMatch,
        ])

        // Compute overall match score
        let overallMatch = calculateOverallGrade(from: [
            mapToGrade(costDetails.averageDebt4YearMatch),
            mapToGrade(costDetails.averageNetPricePublic),
            mapToGrade(costDetails.averageNetPricePrivate),
            mapToGrade(costDetails.inStateTuitionMatch),
            mapToGrade(costDetails.outStateTuitionMatch),
            mapToGrade(costDetails.coaAcademicYearMatch),
            mapToGrade(admissionsDetails.actScoreMatch),
            mapToGrade(admissionsDetails.satScoreMatch),
            mapToGrade(admissionsDetails.admissionsRateMatch),
            mapToGrade(academicScore),
            mapToGrade(campusScore),
            mapToGrade(outcomesDetails.gradRateMatch),
            mapToGrade(outcomesDetails.percentEarningMoreThanHSGradMatch),
            mapToGrade(outcomesDetails.workingNotEnrolledMatch),
        ])

        // Create the StudentSchoolMatch object
        let match = StudentSchoolMatch(
            id: UUID(),
            studentId: UUID(uuidString: student.id) ?? UUID(),
            schoolId: school.id,
            costScore: costScore,
            academicScore: academicScore,
            admissionScore: admissionScore,
            campusScore: campusScore,
            outcomesScore: outcomesScore,
            matchScore: overallMatch,
            averageDebt4YearMatch: costDetails.averageDebt4YearMatch,
            averageNetPricePublic: costDetails.averageNetPricePublic,
            averageNetPricePrivate: costDetails.averageNetPricePrivate,
            inStateTutionMatch: costDetails.inStateTuitionMatch,
            outStateTutionMatch: costDetails.outStateTuitionMatch,
            coaAcademicYearMatch: costDetails.coaAcademicYearMatch,
            carnegieMatch: "N/A",
            studentToFacultyRatioMatch: academicDetails,
            areasofStudyMatch: "N/A",
            actScoreMatch: admissionsDetails.actScoreMatch,
            satScoreMatch: admissionsDetails.satScoreMatch,
            admissionsRateMatch: admissionsDetails.admissionsRateMatch,
            sizeMatch: campusDetails,
            localeMatch: "N/A",
            religiousAffiliationMatch: "N/A",
            menMatch: "N/A",
            womenMatch: "N/A",
            fourYearGradRateMatch: outcomesDetails.gradRateMatch,
            fourYearRetentionRateMatch: "N/A",
            lessThanFourYearRetentionRateMatch: "Medium",
            percentEarningMoreThanHSGradMatch: outcomesDetails
                .percentEarningMoreThanHSGradMatch,
            notWorkingNotEnrolledMatch: outcomesDetails.workingNotEnrolledMatch,
            workingNotEnrolledMatch: "N/A"
        )

        // Print all match details with actual stats
        print(
            """
            ============================================
            Match Results for School: \(school.name ?? "Unknown School")
            --------------------------------------------
            Overall Match Score: \(match.matchScore)

            Cost Details:
              - Cost Score: \(match.costScore)
              - Average Debt 4-Year: \(school.averageDebt ?? 0) → \(match.averageDebt4YearMatch)
              - In-State Tuition: \(school.inStateTuition ?? 0) → \(match.inStateTutionMatch)
              - Out-State Tuition: \(school.outStateTuition ?? 0) → \(match.outStateTutionMatch)
              - COA Academic Year: \(school.coaAcademicYear ?? 0) → \(match.coaAcademicYearMatch)
              - Average Net Price Public: \(school.averageNetPricePublic ?? 0) → \(match.averageNetPricePublic)
              - Average Net Price Private: \(school.averageNetPricePrivate ?? 0) → \(match.averageNetPricePrivate)

            Admissions Details:
              - Admission Score: \(match.admissionScore)
              - ACT Score: \(school.actScore ?? 0) → \(match.actScoreMatch)
              - SAT Score: \(school.satScore ?? 0) → \(match.satScoreMatch)
              - Admissions Rate: \(school.admissionsRate ?? 0.0) → \(match.admissionsRateMatch)

            Academic Details:
              - Academic Score: \(match.academicScore)
              - Student-to-Faculty Ratio: \(school.studentToFacultyRatio ?? 0) → \(match.studentToFacultyRatioMatch)
              - Areas of Study Match: \(match.areasofStudyMatch)

            Campus Details:
              - Campus Score: \(match.campusScore)
              - Campus Size: \(school.size ?? 0) → \(match.sizeMatch)
              - Locale Match: \(match.localeMatch)
              - Religious Affiliation Match: \(match.religiousAffiliationMatch)

            Outcomes Details:
              - Outcomes Score: \(match.outcomesScore)
              - Graduation Rate: \(school.fourYearGradRate ?? 0.0) → \(match.fourYearGradRateMatch)
              - Percent Earning More Than HS Grad: \(school.percentEarningMoreThanHSGrad ?? 0.0) → \(match.percentEarningMoreThanHSGradMatch)
            - Working Not Enrolled: \(String(format: "%.2f", school.workingNotEnrolled ?? 0.0)) → \(match.workingNotEnrolledMatch)

            ============================================
            """
        )

        return match
    }

    private static func calculateCostDetails(for school: School) -> (
        averageDebt4YearMatch: String,
        inStateTuitionMatch: String,
        outStateTuitionMatch: String,
        coaAcademicYearMatch: String,
        averageNetPricePublic: String,
        averageNetPricePrivate: String
    ) {
        return (
            averageDebt4YearMatch: Classify.classifyAverageDebt(
                school.averageDebt),
            inStateTuitionMatch: Classify.classifyInStateTuition(
                school.inStateTuition),
            outStateTuitionMatch: Classify.classifyOutStateTuition(
                school.outStateTuition),
            coaAcademicYearMatch: Classify.classifyCOAAcademicYear(
                school.coaAcademicYear.map(Float.init)),
            averageNetPricePublic: Classify.classifyNetPricePublic(
                school.averageNetPricePublic.map(Float.init)),
            averageNetPricePrivate: Classify.classifyNetPricePrivate(
                school.averageNetPricePrivate.map(Float.init))
        )
    }

    private static func calculateAdmissionsDetails(
        for school: School, student: StudentInfo
    ) -> (
        actScoreMatch: String,
        satScoreMatch: String,
        admissionsRateMatch: String
    ) {
        let actScoreMatch = Classify.classifyACTScore(
            actual: student.actScore.map(Float.init),
            target: school.actScore
        )
        let satScoreMatch = Classify.classifySATScore(
            actual: student.satScore.map(Float.init),
            target: school.satScore
        )
        let admissionsRateMatch = Classify.classifyAdmissionsRate(
            school.admissionsRate)

        return (actScoreMatch, satScoreMatch, admissionsRateMatch)
    }

    private static func calculateAcademicsDetails(for school: School) -> String
    {
        return Classify.classifyStudentFacultyRatio(
            school.studentToFacultyRatio)
    }

    private static func calculateCampusDetails(for school: School) -> String {
        return Classify.classifyCampusSize(school.size.map(Float.init))
    }

    private static func calculateOutcomesDetails(for school: School) -> (
        gradRateMatch: String,
        percentEarningMoreThanHSGradMatch: String,
        workingNotEnrolledMatch: String
    ) {
        let gradRateMatch = Classify.classifyGradRate(school.fourYearGradRate)
        let percentEarningMoreThanHSGradMatch = Classify.classifyEarningMore(
            school.percentEarningMoreThanHSGrad)
        let workingNotEnrolledMatch = Classify.classifyWorkingNotEnrolled(
            school.workingNotEnrolled.map(Float.init))

        return (
            gradRateMatch, percentEarningMoreThanHSGradMatch,
            workingNotEnrolledMatch
        )
    }

    private static func calculateOverallGrade(from sectionScores: [String])
        -> String
    {
        let gradeValues: [String: Double] = [
            "A+": 4.3, "A": 4.0, "A-": 3.7,
            "B+": 3.3, "B": 3.0, "B-": 2.7,
            "C+": 2.3, "C": 2.0, "C-": 1.7,
            "Low": 2.0, "Medium": 3.0, "High": 4.0,
        ]

        // Check if all scores are "N/A"
        if sectionScores.allSatisfy({ $0 == "N/A" }) {
            return "N/A"
        }

        // Convert section grades to numeric scores, ignoring "N/A"
        let numericScores = sectionScores.compactMap { grade in
            grade == "N/A" ? nil : gradeValues[grade]
        }

        // Debug log for input and valid scores
        print(
            "Input Scores: \(sectionScores) → Valid Numeric Scores: \(numericScores)"
        )

        // Handle the case where no valid scores exist
        guard !numericScores.isEmpty else { return "C-" }

        // Calculate the average numeric score
        let average = numericScores.reduce(0, +) / Double(numericScores.count)

        // Map the average numeric score back to a grade
        switch average {
        case 4.3...: return "A+"
        case 4.0..<4.3: return "A"
        case 3.7..<4.0: return "A-"
        case 3.3..<3.7: return "B+"
        case 3.0..<3.3: return "B"
        case 2.7..<3.0: return "B-"
        case 2.3..<2.7: return "C+"
        case 2.0..<2.3: return "C"
        case 1.7..<2.0: return "C-"
        default: return "C-"  // Minimum grade
        }
    }

    // MARK: - Helpers
    private static func matchCategory(
        _ value: Float?, thresholds: [Double], reverse: Bool = false
    ) -> String {
        guard let value = value.map(Double.init) else { return "N/A" }  // Convert Float? to Double
        if reverse {
            switch value {
            case ..<thresholds[0]: return "High"
            case thresholds[0]..<thresholds[1]: return "Medium"
            default: return "Low"
            }
        } else {
            switch value {
            case ..<thresholds[0]: return "Low"
            case thresholds[0]..<thresholds[1]: return "Medium"
            default: return "High"
            }
        }
    }

    private static func mapToGrade(_ match: String) -> String {
        switch match {
        case "Low": return "C"
        case "Medium": return "B"
        case "High": return "A"
        default: return "N/A"
        }
    }
}
