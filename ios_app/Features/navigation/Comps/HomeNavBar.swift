//
//  FindUNavBarView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//
import SwiftUI

struct HomeNavBar: View {
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "heart")
                    .font(.title)
                Text("Saved")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
            
            VStack {
                Image(systemName: "paintbrush")
                    .font(.title)
                Text("Explore")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.red)
            
            VStack {
                Image(systemName: "gear")
                    .font(.title)
                Text("Settings")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(.primary)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .shadow(radius: 5)
    }
}
