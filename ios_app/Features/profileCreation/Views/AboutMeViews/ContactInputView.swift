//
//  ContactInputView.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

//TODO: Might have to make this scrollView in the future
struct ContactInputView : View{
    @Binding var studentPhone: String
    @Binding var studentContactMethod: String
    
    var body: some View{
        ScrollView {
            VStack(alignment: .center, spacing: 36.0) {
                VStack(alignment: .center, spacing: 24.0) {
                    Text("What's your phone number?").centeredTitleTextStyle()
                    
                    PhoneNumberTextField(userInput: $studentPhone, placeholder: "(123) - 456 - 7890")
                }
                VStack(alignment: .center, spacing: 24.0) {
                    Text("How do you prefer colleges to reach out to you?").centeredTitleTextStyle()
                    
                    SingleSelectBtns(selectedOption: $studentContactMethod, options: ContactMethod.allCases.map { $0.rawValue })
                }
                
            }.padding(.horizontal, 1)
        }
    }
}

#Preview {
    ContactInputView(studentPhone: .constant(""), studentContactMethod: .constant(""))
}
