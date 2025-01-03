//
//  ios_appApp.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//

import SwiftUI
import GoogleSignIn

@main
struct ios_app: App {
    @StateObject private var globalStudentState = GlobalStudentDataState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalStudentState)
                .onOpenURL { url in
                          GIDSignIn.sharedInstance.handle(url)
                        }
                .onAppear {
                          GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                          }
                        }
        }
    }
}
