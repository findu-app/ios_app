//
//  StudentSchoolMatch.swift
//  ios_app
//
//  Created by Kenny Morales on 1/10/25.
//


import Foundation

struct StudentSchoolMatch: Codable, Identifiable {
    // Primary key for this table (optional, if your DB sets it automatically)
    let id: UUID
    // Reference to the student's ID
    let studentId: UUID
    // Reference to the school's ID
    let schoolId: UUID
    // The match score itself
    var matchScore: Double
}