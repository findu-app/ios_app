//
//  StudentModel.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/29/24.
//


import Foundation

struct StudentModel: Identifiable, Codable {
    let id: String
    let email: String
    let studentID: String

    init(from user: UserModel, studentID: String) {
        self.id = user.id
        self.email = user.email
        self.studentID = studentID
    }
}


