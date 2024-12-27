//
//  Substep1.swift
//  ios_app
//
//  Created by Kenny Morales on 12/27/24.
//

import SwiftUI

//TODO: Might have to make this scrollView in the future
struct Substep1 : View{
    var body: some View{
        VStack(alignment: .leading, spacing: 36.0) {
            VStack(alignment: .leading, spacing: 24.0) {
                Text("Phone Number")
                    .font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                    .foregroundColor(Color("OnSurface"))
                PhoneNumberTextField()
            }
            VStack(alignment: .leading, spacing: 24.0) {
                Text("How do you want colleges to reach out to you?").font(Font.custom("Plus Jakarta Sans SemiBold", size: 24))
                    .foregroundColor(Color("OnSurface"))
                SingleSelectBtns(options: ["Email", "Phone", "Messages"])
            }
           
        }
        
    }

}

#Preview {
    Substep1()
}
