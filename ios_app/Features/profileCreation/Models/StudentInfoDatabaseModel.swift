//
//  StudentInfoDatabaseModel.swift
//  ios_app
//
//  Created by Kenny Morales on 1/2/25.
//


import Foundation

struct StudentInfoDatabaseModel: Encodable {
    let name: String
    let phone: String
    let preferred_contact_method: String
    let address: String
    let high_school_name: String
    let high_school_address: String
    let graduation_year: String
    let gender: String
    let household_income: String
    let financial_aid_need: Bool
    let gpa: Double
    let act_score: Int?
    let sat_score: Int?
    let class_rank: String
    let num_ap_classes: Int
    let activities: [String]
    let hobbies: [String]
    let volunteer_hours: String
    let majors: [String]
    let distance_from_home: String
    let preferred_setting: String
    let preferred_size: String
    let rigor: String
    let campus_culture_preferences: [String]
    let special_programs: Bool
    let greek_life_interest: Bool
    let research_interest: Bool
    let ethnicity: String
}
