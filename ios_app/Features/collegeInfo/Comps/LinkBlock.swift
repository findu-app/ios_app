//
//  LinkBlock.swift
//  ios_app
//
//  Created by Kenny Morales on 1/7/25.
//

import SwiftUI

struct LinkBlock: View {
    var title: String
    var url: String
    
    var body: some View {
        HStack(spacing: 8) {
            Link(destination: URL(string: url)!, label: {
                Image(systemName: "link")
                    .resizable()
                    .scaledToFit()
                    .fontWeight(.bold)
                    .frame(height: 14)
                    .foregroundColor(Color("OnSurface"))
                Text(title)
                    .font(Font.custom("Plus Jakarta Sans Medium", size: 14))
                    .foregroundColor(Color("OnSurface"))
                    .underline()
            })
                
        }
    }
}
