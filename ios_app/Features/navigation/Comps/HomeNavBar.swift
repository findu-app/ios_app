//
//  HomeNavBar.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//
import SwiftUI

struct HomeNavBar: View {
    var body: some View {
        Divider()
            .frame(height: 1)
            .background(Color.gray.opacity(0.5))
        HStack {
            VStack {
                Image(systemName: "heart")
                    .font(.title)
                Text("Saved")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 9))
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
            
            VStack {
                Image(systemName: "safari")
                    .font(.title)
                Text("Explore")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 9))
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
            
            VStack {
                Image(systemName: "gear")
                    .font(.title)
                Text("Settings")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 9))
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
        }
        .padding()
        .padding(.bottom, 29)
        .background(Color("surface"))
    }
}

#Preview {
    HomeNavBar()
}
