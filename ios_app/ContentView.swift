//
//  ContentView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/26/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var globalStudentState: GlobalStudentDataState

    var body: some View {
        if globalStudentState.studentInfo == nil {
            // Show CreationFlow if no StudentInfo exists
            StudentProfileCreationFlow()
        } else {
            // Show HomePage if StudentInfo exists
            HomePage()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GlobalStudentDataState())  // Inject GlobalStudentState for preview
}
