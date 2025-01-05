//
//  SchoolCardView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//

import SwiftUI

struct SchoolCardView: View {
    let school: School
    let student: StudentInfo
    
    func calculateMatchScore() -> Int {
        var score = 0.0
        var maxPossibleScore = 0.0

        if let schoolSAT = school.averageSAT, let studentSAT = student.satScore {
            if studentSAT >= Int(schoolSAT) {
                score += 40.0
            } else if studentSAT >= Int(schoolSAT) - 100 {
                score += 20.0
            }
            maxPossibleScore += 40.0
        }

        if let size = school.size {
            let preferredRange: ClosedRange<Int>
            
            switch student.preferredSize {
            case "Small":
                preferredRange = 1...5000
            case "Medium":
                preferredRange = 5001...15000
            case "Large":
                preferredRange = 15001...Int.max
            default:
                preferredRange = 0...Int.max
            }
            
            if preferredRange.contains(size) {
                score += 30.0
            }
            maxPossibleScore += 30.0
        }


        if let coa = school.coaAcademicYear {
            let householdIncome = getHouseholdIncomeRangeValue(student.householdIncome)
            if coa <= householdIncome {
                score += 30.0
            } else if coa <= householdIncome + 5000 {
                score += 15.0
            }
            maxPossibleScore += 30.0
        }

        let normalizedScore = (score / maxPossibleScore) * 99.0
        return Int(round(normalizedScore))
    }

    func getHouseholdIncomeRangeValue(_ incomeRange: String) -> Int {
        switch incomeRange {
        case "Under 65,000":
            return 65000
        case "65,000 - 120,000":
            return 120000
        case "Over 120,000":
            return Int.max
        default:
            return 0
        }
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(school.name)
                .font(.headline)
            if let city = school.city, let state = school.state {
                Text("\(city), \(state)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            if let size = school.size {
                Text("Student Size: \(size)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let averageSAT = school.averageSAT {
                Text("Average Test Score: \(Int(averageSAT))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            if let coaAcademicYear = school.coaAcademicYear {
                Text("Cost of Attendance (Academic Year): \(coaAcademicYear)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Text("Match Score: \(calculateMatchScore())")
                            .font(.subheadline)
                            .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
