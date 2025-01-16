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
            Menu("Name") {
                Button("Ascending") { onSortSelected(.name, true) }
                Button("Descending") { onSortSelected(.name, false) }
            }
            Menu("Average Debt") {
                Button("Low to High") { onSortSelected(.averageDebt, true) }
                Button("High to Low") { onSortSelected(.averageDebt, false) }
            }
            Menu("Admissions Rate") {
                Button("Low to High") { onSortSelected(.admissionsRate, true) }
                Button("High to Low") { onSortSelected(.admissionsRate, false) }
            }
            Menu("ACT Score") {
                Button("Low to High") { onSortSelected(.actScore, true) }
                Button("High to Low") { onSortSelected(.actScore, false) }
            }
            Menu("SAT Score") {
                Button("Low to High") { onSortSelected(.satScore, true) }
                Button("High to Low") { onSortSelected(.satScore, false) }
            }
            Menu("Average Aid") {
                Button("Low to High") { onSortSelected(.averageAid, true) }
                Button("High to Low") { onSortSelected(.averageAid, false) }
            }
            Menu("Average Net Price") {
                Button("Low to High") { onSortSelected(.averageNetPrice, true) }
                Button("High to Low") { onSortSelected(.averageNetPrice, false) }
            }
            Menu("Cost of Attendance") {
                Button("Low to High") { onSortSelected(.costOfAttendance, true) }
                Button("High to Low") { onSortSelected(.costOfAttendance, false) }
            }
            Menu("In-State Tuition") {
                Button("Low to High") { onSortSelected(.inStateTuition, true) }
                Button("High to Low") { onSortSelected(.inStateTuition, false) }
            }
            Menu("Out-of-State Tuition") {
                Button("Low to High") { onSortSelected(.outStateTuition, true) }
                Button("High to Low") { onSortSelected(.outStateTuition, false) }
            }
            Menu("Size") {
                Button("Small to Large") { onSortSelected(.size, true) }
                Button("Large to Small") { onSortSelected(.size, false) }
            }
            Menu("Student-to-Faculty Ratio") {
                Button("Low to High") { onSortSelected(.studentToFacultyRatio, true) }
                Button("High to Low") { onSortSelected(.studentToFacultyRatio, false) }
            }
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
