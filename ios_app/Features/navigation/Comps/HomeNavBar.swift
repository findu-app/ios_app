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
            HomeNavBarIconButton(
                icon: "heart",
                label: "Saved",
                isSelected: selectedTab == .saved
            ) {
                selectedTab = .saved
            }

            HomeNavBarIconButton(
                icon: "safari",
                label: "Explore",
                isSelected: selectedTab == .explore
            ) {
                selectedTab = .explore
            }

            HomeNavBarIconButton(
                icon: "gearshape",
                label: "Settings",
                isSelected: selectedTab == .settings
            ) {
                selectedTab = .settings
            }
        }
        .padding()
        .padding(.bottom, 20) //Added to offset the bottom spacing
        .background(Color("Surface"))
    }
}

#Preview {
    HomeNavBar(selectedTab: .constant(.explore))
}
