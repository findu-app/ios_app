//
//  DemographicsDisplayView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/9/25.
//


import SwiftUI

struct DemographicsDisplayView: View {
    let school: SchoolAPI

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Demographics")
                .font(.title2)
                .fontWeight(.bold)

            // Gender Breakdown
            VStack(alignment: .leading, spacing: 8) {
                Text("Gender Breakdown")
                    .font(.headline)
                HStack {
                    if let men = school.men {
                        Text("Men: \(String(format: "%.1f", men * 100))%")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    if let women = school.women {
                        Text("Women: \(String(format: "%.1f", women * 100))%")
                            .font(.subheadline)
                            .foregroundColor(.pink)
                    }
                }
            }

            Divider()

            // Race/Ethnicity Breakdown
            VStack(alignment: .leading, spacing: 8) {
                Text("Race/Ethnicity Breakdown")
                    .font(.headline)
                if let race = school.white {
                    VStack(alignment: .leading, spacing: 6) {
                        if let white = school.white {
                            Text("White: \(String(format: "%.1f", white * 100))%")
                        }
                        if let black = school.black {
                            Text("Black: \(String(format: "%.1f", black * 100))%")
                        }
                        if let hispanic = school.hispanic {
                            Text("Hispanic: \(String(format: "%.1f", hispanic * 100))%")
                        }
                        if let asian = school.asian {
                            Text("Asian: \(String(format: "%.1f", asian * 100))%")
                        }
                        if let aian = school.aian {
                            Text("American Indian/Alaska Native: \(String(format: "%.1f", aian * 100))%")
                        }
                        if let nhpi = school.nhpi {
                            Text("Native Hawaiian/Pacific Islander: \(String(format: "%.1f", nhpi * 100))%")
                        }
                        if let twoOrMore = school.twoOrMore {
                            Text("Two or More Races: \(String(format: "%.1f", twoOrMore * 100))%")
                        }
                        if let nonResidentAlien = school.nonResidentAlien {
                            Text("Non-Resident Alien: \(String(format: "%.1f", nonResidentAlien * 100))%")
                        }
                        if let unknown = school.unknown {
                            Text("Unknown: \(String(format: "%.1f", unknown * 100))%")
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                } else {
                    Text("Race/Ethnicity data not available.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
