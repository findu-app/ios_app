//
//  SectionTitle.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct SectionTitle: View {
    var title: String
    var matchScore: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(
                    Font.custom("Plus Jakarta Sans SemiBold", size: 18))
            Spacer()
            Text(matchScore)
                .font(
                    Font.custom("Plus Jakarta Sans Bold", size: 24)
                )
                .foregroundStyle(Color.green)
        }
    }
}

#Preview {
    SectionTitle(title: "Title", matchScore: "100")
}
