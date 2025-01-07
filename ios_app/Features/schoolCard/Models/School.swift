//
//  School.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//


struct SchoolsResponse: Decodable {
    let results: [School]
}

struct School: Decodable, Identifiable {
    let id: Int
    let name: String
    let city: String?
    let state: String?
    let size: Int?
    let averageSAT: Float?
//    let inStateTuition: Int?
    let coaAcademicYear: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "school.name"
        case city = "school.city"
        case state = "school.state"
        case size = "latest.student.size"
        case averageSAT = "latest.admissions.sat_scores.average.overall"
//        case inStateTuition = "latest.cost.tuition.in_state"
        case coaAcademicYear = "latest.cost.attendance.academic_year"
    }
}