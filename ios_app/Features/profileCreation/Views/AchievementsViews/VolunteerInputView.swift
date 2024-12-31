//
//  VolunteerInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct VolunteerInputView: View {
    @Binding var studentVolunteerHours: String

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 36.0) {
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What range of volunteer hours have you completed?").centeredTitleTextStyle()
                    
                    SingleSelectBtns(
                        selectedOption: $studentVolunteerHours,
                        options: VolunteerHours.allCases.map { $0.rawValue }
                    )
                }
            }
            .padding(.horizontal, 1)
        }
    }
}

#Preview {
    VolunteerInputView(
        studentVolunteerHours: .constant(""))
}
