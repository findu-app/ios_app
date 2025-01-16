//
//  SettingsViewModel.swift
//  ios_app
//
//  Created by Kenny Morales on 1/10/25.
//

import SwiftUI

@MainActor
class SettingsViewModel: ObservableObject {
    private var globalStudentState: GlobalStudentDataState

    init(globalStudentState: GlobalStudentDataState) {
        self.globalStudentState = globalStudentState
    }

    func printStudentState() {
        print("Global Student State: \(globalStudentState)")
    }
}
