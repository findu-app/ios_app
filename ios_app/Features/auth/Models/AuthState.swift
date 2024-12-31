//
//  AuthState.swift
//  ios_app
//
//  Created by Wilson Overfield on 12/29/24.
//
import Combine

class AuthState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var user: UserModel?
}
