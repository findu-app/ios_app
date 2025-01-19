//
//  HomeHeader.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

//
//  HomeHeader.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/6/25.
//

import SwiftUI

struct HomeHeader: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isDrawerOpen = false
    @EnvironmentObject var globalStudentState: GlobalStudentDataState

    var body: some View {
        VStack {
            HStack {
                Image(
                    colorScheme == .dark
                        ? "finduLogoFull_dark" : "finduLogoFull_light"
                )
                .resizable()
                .scaledToFit()
                .frame(height: 24)

                Spacer()

                Button(action: {
                    withAnimation {
                        isDrawerOpen = true
                    }
                }) {
                    HStack(alignment: .center) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("OnSurface"))
                            .padding(4)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)

            Divider()
                .frame(height: 1)
                .background(Color("Border"))
        }
        .sheet(isPresented: $isDrawerOpen) {
            SearchSheet(
                isPresented: $isDrawerOpen,
                viewModel: SearchSheetViewModel(globalStudentState: globalStudentState)
            )
        }
        .background(Color("Surface"))
    }
}

#Preview {
    HomeHeader()
}
