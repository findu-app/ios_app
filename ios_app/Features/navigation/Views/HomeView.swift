//
//  HomeView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .explore
    @State private var isOnSubPage: Bool = false
    @EnvironmentObject var globalStudentState: GlobalStudentDataState


    var body: some View {
        VStack(spacing: 0) {
            if !isOnSubPage {
                HomeHeader()
                Spacer()
            }

            Group {
                switch selectedTab {
                case .saved:
                    AnyView(SavedView())
                case .explore:
                    AnyView(
                        ExploreView()
                            .environmentObject(globalStudentState))
                case .settings:
                    AnyView(
                        SettingsView(isOnSubPage: $isOnSubPage)
                            .environmentObject(globalStudentState))
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
