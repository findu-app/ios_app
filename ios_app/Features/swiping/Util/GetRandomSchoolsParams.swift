//
//  GetRandomSchoolsParams.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/18/25.
//

import Foundation

struct GetRandomSchoolsParams: Encodable {
    let student_id: UUID
    let count: Int
}
