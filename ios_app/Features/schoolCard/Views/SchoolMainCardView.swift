//
//  SchoolCardView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/4/25.
//

import SwiftUI

struct SchoolMainCardView: View {
    let school: SchoolAPI
    let student: StudentInfo
    
    func calculateMatchScore() -> Int {
        var score = 0.0
        var maxPossibleScore = 0.0

        if let schoolSAT = school.sat, let studentSAT = student.satScore {
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
            // Display basic school info
            Text(school.name)
                .font(.headline)
            let city = school.city
            let state = school.state
            Text("\(city), \(state)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if let lat = school.latitude, let lon = school.longitude {
                Text("Latitude: \(lat), Longitude: \(lon)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Display additional data fields
            if let size = school.size {
                Text("Student Size: \(size)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
                Text("School Area: \(school.localeDescription)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            
            if let averageSAT = school.sat {
                Text("Average SAT Score: \(Int(averageSAT))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let averageACT = school.act {
                Text("Average ACT Score: \(Int(averageACT))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let areas = school.areasOfStudy {
                ForEach(areas, id: \.code) { area in
                    if let code = area.code {
                        Text("Code: \(code)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    if let cleanedTitle = area.cleanedTitle {
                        Text("Title: \(cleanedTitle)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    if let level = area.credential?.level {
                        Text("Credential Level: \(level)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    if let salary = area.afterCollegeSalary {
                        Text("After College Salary: \(salary)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            } else {
                Text("Areas of Study: Not Available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Demographics
            DemographicsDisplayView(school: school)

            
            if let coaAcademicYear = school.coaAcademicYear {
                Text("Cost of Attendance (Academic Year): \(coaAcademicYear)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let avgNetPricePublic = school.averageNetPricePublic {
                Text("Average Net Price (Public): \(avgNetPricePublic)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let avgNetPricePrivate = school.averageNetPricePrivate {
                Text("Average Net Price (Private): \(avgNetPricePrivate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let averageDebt = school.averageDebt {
                Text("Average Debt: \(averageDebt, specifier: "$%.0f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if let inStateTuition = school.inStateTuition {
                Text("In-State Tuition: \(inStateTuition, specifier: "$%.0f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let outStateTuition = school.outStateTuition {
                Text("Out-of-State Tuition: \(outStateTuition, specifier: "$%.0f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
                        
            if let studentToFaculty = school.studentToFaculty {
                Text("Student-to-Faculty Ratio: \(studentToFaculty, specifier: "%.2f")")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if let admissionsRate = school.admissionsRate {
                Text("Admissions Rate: \(admissionsRate * 100, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
        
            Text("Religious Affiliation: \(school.religiousAffiliationDescription)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

            if let fourYearGradRate = school.fourYearGradRate {
                Text("4-Year Graduation Rate: \(fourYearGradRate * 100, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let fourYearRate = school.fourYearRetentionRate {
                Text("4-Year Retention Rate: \(fourYearRate * 100, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            if let ltFourYearRate = school.lessThanFourYearRetentionRate {
                Text("Less-than-4-Year Retention Rate: \(ltFourYearRate * 100, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let earningThanHSGrad = school.percentEarningMoreThanHSGrad {
                Text("Percent earning more than HS grad: \(earningThanHSGrad * 100, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let employmentRate = school.calculatedEmploymentRate {
                Text("Employment Rate: \(employmentRate, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("Employment Rate: Not Available")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }


            // Display match score
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
