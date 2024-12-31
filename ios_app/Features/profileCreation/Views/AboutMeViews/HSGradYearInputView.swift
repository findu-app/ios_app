//
//  HSGradYearInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/29/24.
//

import SwiftUI

struct HSGradYearInputView: View {
    @Binding var studentHSGradYear: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24.0) {
                Text("What year do you graduate from high school?").centeredTitleTextStyle()
                
                SingleSelectBtns(selectedOption: $studentHSGradYear, options: ["2025", "2026", "2027", "2028"])
            }.padding(.horizontal, 1)
        }
    }
}

#Preview {
    HSGradYearInputView(studentHSGradYear: .constant(""))
}
