//
//  ios_appApp.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//

import SwiftUI

@main
struct ios_app: App {
    @StateObject private var globalStudentState = GlobalStudentDataState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalStudentState)
        }
    }
}
