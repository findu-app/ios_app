//
//  StudentSchoolInteraction.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/9/25.
//

import Foundation

struct StudentSchoolInteraction: Codable, Identifiable, Equatable {
    let id: UUID
    let studentId: UUID
    let schoolId: UUID
    let viewed: Bool
    let liked: Bool
    let disliked: Bool
    let matchScore: String?
    var likedMost: [String]?
    var worriedAbout: [String]?
    var questions: String?
    let interactionDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case studentId = "student_id"
        case schoolId = "school_id"
        case viewed
        case liked
        case disliked
        case matchScore = "match_score"
        case likedMost = "liked_most"
        case worriedAbout = "worried_about"
        case questions
        case interactionDate = "interaction_date"
    }
}
