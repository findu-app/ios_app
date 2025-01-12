//
//  StudentSchoolMatch.swift
//  ios_app
//
//  Created by Kenny Morales on 1/10/25.
//

import Foundation

/// Represents a match between a student and a school, including detailed scores and overall compatibility.
struct StudentSchoolMatch: Codable, Identifiable {
    let id: UUID
    let studentId: UUID
    let schoolId: UUID
    // MARK: Match Scores
    var costScore: String
    var academicScore: String
    var admissionScore: String
    var campusScore: String
    var outcomesScore: String
    var matchScore: String
    
    // MARK: Individual Scores and Match
    let averageDebt4YearMatch: String
    let averageNetPricePublic: String?
    let averageNetPricePrivate: String?
    let inStateTutionMatch: String
    let outStateTutionMatch: String
    let coaAcademicYearMatch: String
    let financialAidMatch: String
    
    let carnegieMatch: String
    let studentToFacultyRatioMatch: String
    let areasofStudyMatch: String
    
    let actScoreMatch: String
    let satScoreMatch: String
    let admissionsRateMatch: String
    let chancesOfAcceptanceMatch: String
    
    let sizeMatch: String
    let localeMatch: String
    let religiousAffiliationMatch: String
    let menMatch: String
    let womenMatch: String
    
    let fourYearGradRateMatch: String
    let fourYearRetentionRateMatch: String
    let lessThanFourYearRetentionRateMatch: String
    let percentEarningMoreThanHSGradMatch: String
    let notWorkingNotEnrolledMatch: String
    let workingNotEnrolledMatch: String
}
