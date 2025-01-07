//
//  HomeHeader.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//


import SwiftUI

struct HomeHeader: View {
    var body: some View {
        HStack {
            Text("Find")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text("U")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.red)
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.title)
                .foregroundColor(.primary)
        }
        .padding(.horizontal)
        .padding(.top, 16)
    }
}
