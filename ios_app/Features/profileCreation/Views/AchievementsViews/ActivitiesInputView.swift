//
//  ActivitiesInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct ActivitiesInputView: View {
    @Binding var studentActivities: [String]
    
    var body: some View {
                VStack(alignment: .center, spacing: 8.0) {
                    Text("What activities you’ve done in school!").centeredTitleTextStyle()
                    Text("Select at least 3 options")
                        .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                        .foregroundColor(Color("Secondary"))
                        .multilineTextAlignment(.center)
                    
                    MultiSelectBtns(
                        selectedOptions: $studentActivities,
                        options: Activity.allCases.map { $0.rawValue }
                    )
                }
            }
}

#Preview {
    ActivitiesInputView(studentActivities: .constant([]))
}
