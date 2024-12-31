//
//  User.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/29/24.
//

import Foundation
import Supabase

struct UserModel: Identifiable, Codable {
    let id: String
    let email: String
        
    init(from user: User) {
        self.id = user.id.uuidString
        self.email = user.email ?? "No Email"
    }
}
