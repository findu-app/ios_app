//
//  HomeView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            HomeHeader()
            
            Spacer()
            
            Spacer()
                        
            HomeNavBar()
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("surface"))
    }
}

#Preview {
    HomeView()
}
