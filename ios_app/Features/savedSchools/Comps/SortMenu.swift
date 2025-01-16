//
//  SortMenu.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/16/25.
//


import SwiftUI

struct SortMenu: View {
    let onSortSelected: (SortField, Bool) -> Void

    var body: some View {
        Menu {
            Button("Name (A-Z)") { onSortSelected(.name, true) }
            Button("Name (Z-A)") { onSortSelected(.name, false) }
            Button("Average Debt (Low to High)") { onSortSelected(.averageDebt, true) }
            Button("Average Debt (High to Low)") { onSortSelected(.averageDebt, false) }
            Button("Admissions Rate (Low to High)") { onSortSelected(.admissionsRate, true) }
            Button("Admissions Rate (High to Low)") { onSortSelected(.admissionsRate, false) }
            Button("ACT Score (Low to High)") { onSortSelected(.actScore, true) }
            Button("ACT Score (High to Low)") { onSortSelected(.actScore, false) }
            Button("SAT Score (Low to High)") { onSortSelected(.satScore, true) }
            Button("SAT Score (High to Low)") { onSortSelected(.satScore, false) }
            Button("Average Aid (Low to High)") { onSortSelected(.averageAid, true) }
            Button("Average Aid (High to Low)") { onSortSelected(.averageAid, false) }
            Button("Average Net Price (Low to High)") { onSortSelected(.averageNetPrice, true) }
            Button("Average Net Price (High to Low)") { onSortSelected(.averageNetPrice, false) }
            Button("Cost of Attendance (Low to High)") { onSortSelected(.costOfAttendance, true) }
            Button("Cost of Attendance (High to Low)") { onSortSelected(.costOfAttendance, false) }
            Button("In-State Tuition (Low to High)") { onSortSelected(.inStateTuition, true) }
            Button("In-State Tuition (High to Low)") { onSortSelected(.inStateTuition, false) }
            Button("Out-of-State Tuition (Low to High)") { onSortSelected(.outStateTuition, true) }
            Button("Out-of-State Tuition (High to Low)") { onSortSelected(.outStateTuition, false) }
            Button("Size (Small to Large)") { onSortSelected(.size, true) }
            Button("Size (Large to Small)") { onSortSelected(.size, false) }
            Button("Student-to-Faculty Ratio (Low to High)") { onSortSelected(.studentToFacultyRatio, true) }
            Button("Student-to-Faculty Ratio (High to Low)") { onSortSelected(.studentToFacultyRatio, false) }
        } label: {
            HStack(alignment: .center, spacing: 2) {
                Text("Sort List")
                    .font(Font.custom("Plus Jakarta Sans SemiBold", size: 18))
                    .foregroundColor(Color("Secondary"))
                Image(systemName: "chevron.up.chevron.down")
                    .foregroundColor(Color("Secondary"))
            }
        }
    }
}
