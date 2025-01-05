//
//  School.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//


struct School: Codable {
    let id: Int
    let name: String
    let city: String?
    let state: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "school.name"
        case city = "school.city"
        case state = "school.state"
        case size = "latest.student.size"
    }
}

struct APIResponse: Codable {
    let results: [School]
}
