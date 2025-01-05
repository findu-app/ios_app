//
//  HomePage.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var globalStudentState: GlobalStudentDataState

    var body: some View {
        VStack {
            Text("Welcome, \(globalStudentState.studentInfo?.name ?? "User")!")
                .font(.largeTitle)
                .padding()

            Text("Here's your profile:")
                .font(.headline)

            List {
                Text("Phone: \(globalStudentState.studentInfo?.phone ?? "N/A")")
                Text("Gender: \(globalStudentState.studentInfo?.gender ?? "N/A")")
                Text("High School: \(globalStudentState.studentInfo?.highSchoolName ?? "N/A")")
                // Add more details as needed
            }

            Spacer()
        }
        .padding()
    }
}
