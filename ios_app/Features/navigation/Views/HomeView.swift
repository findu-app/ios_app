//
//  HomeView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .explore

    var body: some View {
        VStack(spacing: 0) {
            HomeHeader()

            Spacer()

            Group {
                switch selectedTab {
                case .saved:
                    SavedView()
                case .explore:
                    ExploreView()
                case .settings:
                    SettingsView()
                }
            }

            Spacer()

            HomeNavBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("Surface"))
    }
}

enum Tab {
    case saved
    case explore
    case settings
}

#Preview {
    HomeView()
}
