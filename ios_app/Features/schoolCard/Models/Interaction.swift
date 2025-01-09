//
//  Interaction.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/9/25.
//


struct Interaction: Decodable, Identifiable, Equatable {
    let id: Int
    let studentId: Int
    let schoolId: Int
    let viewed: Bool
    let liked: Bool
    let disliked: Bool
    let matchScore: Float
    let interactionDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case studentId = "student_id"
        case schoolId = "school_id"
        case viewed
        case liked
        case disliked
        case matchScore = "match_score"
        case interactionDate = "interaction_date"
    }
}
