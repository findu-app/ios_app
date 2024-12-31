//
//  HobbiesInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/30/24.
//

import SwiftUI

struct HobbiesInputView: View {
    @Binding var studentHobbies: [String]
    
    var body: some View {
                VStack(alignment: .center, spacing: 8.0) {
                    Text("What are your current hobbies?").centeredTitleTextStyle()
                    Text("Select at least 3 options")
                        .font(Font.custom("Plus Jakarta Sans Regular", size: 16))
                        .foregroundColor(Color("Secondary"))
                        .multilineTextAlignment(.center)
                    
                    MultiSelectBtns(
                        selectedOptions: $studentHobbies,
                        options: Hobby.allCases.map { $0.rawValue }
                    )
                }
            }
}

#Preview {
    HobbiesInputView(studentHobbies: .constant([]))
}
