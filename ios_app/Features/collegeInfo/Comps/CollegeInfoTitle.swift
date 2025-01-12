//
//  CollegeInfoTitle.swift
//  ios_app
//
//  Created by Kenny Morales on 1/8/25.
//

import SwiftUI



struct CollegeInfoTitle: View {
    var school: String = "University of California, Los Angeles"
    var cityState: String = "Los Angeles, CA"
    var matchScore: String = "A+"

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                // School name
                Text(school)
                    .font(Font.custom("Plus Jakarta Sans Bold", size: 20))
                    .foregroundColor(Color("OnSurface"))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer() // Pushes Match Score to the right

                // Match Score
                VStack() {
                    Text(matchScore)
                        .font(Font.custom("Plus Jakarta Sans Bold", size: 26))
                        .foregroundColor(StatFormatter.colorForMatchScore(matchScore))
                    Text("Match")
                        .font(Font.custom("Plus Jakarta Sans SemiBold", size: 10))
                        .foregroundColor(StatFormatter.colorForMatchScore(matchScore))
                }
            }

            // City and state
            Text(cityState)
                .font(Font.custom("Plus Jakarta Sans Medium", size: 14))
                .foregroundColor(Color("Secondary"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CollegeInfoTitle()
}
