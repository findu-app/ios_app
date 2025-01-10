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
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                // School name
                Text(school)
                    .font(Font.custom("Plus Jakarta Sans Bold", size: 24))
                    .foregroundColor(Color("OnSurface"))
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer() // Pushes Match Score to the right

                // Match Score
                VStack(spacing: 4) {
                    Text(matchScore)
                        .font(Font.custom("Plus Jakarta Sans Bold", size: 32))
                        .foregroundColor(Color("OnSurface"))
                    Text("Match Score")
                        .font(Font.custom("Plus Jakarta Sans SemiBold", size: 12))
                        .foregroundColor(Color("OnSurface"))
                }
            }

            // City and state
            Text(cityState)
                .font(Font.custom("Plus Jakarta Sans Medium", size: 16))
                .foregroundColor(Color("Secondary"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    CollegeInfoTitle()
}
