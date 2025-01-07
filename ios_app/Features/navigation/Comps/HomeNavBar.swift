//
//  HomeNavBar.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//
import SwiftUI

struct HomeNavBar: View {
    @Binding var selectedTab: Tab

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
            .foregroundColor(selectedTab == .saved ? Color("primary") : Color("onSurface"))
            .onTapGesture {
                selectedTab = .saved
            }

            VStack {
                Image(systemName: "safari.fill")
                    .font(.title)
                Text("Explore")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 9))
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == .explore ? Color("primary") : Color("onSurface"))
            .onTapGesture {
                selectedTab = .explore
            }

            VStack {
                Image(systemName: "gear")
                    .font(.title)
                Text("Settings")
                    .font(Font.custom("Plus Jakarta Sans Regular", size: 9))
            }
            .frame(maxWidth: .infinity)
            .foregroundColor(selectedTab == .settings ? Color("primary") : Color("onSurface"))
            .onTapGesture {
                selectedTab = .settings
            }
        }
        .padding()
        .padding(.bottom, 29)
        .background(Color("surface"))
    }
}

#Preview {
    HomeNavBar(selectedTab: .constant(.explore))
}
