//
//  SavedView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//


import SwiftUI

struct SavedView: View {
    var body: some View {
        Text("Saved Content")
            .font(.largeTitle)
            .padding()
    }
}

struct ExploreView: View {
    var body: some View {
        Text("Explore Content")
            .font(.largeTitle)
            .padding()
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Content")
            .font(.largeTitle)
            .padding()
    }
}

#Preview {
    Group {
        SavedView()
        ExploreView()
        SettingsView()
    }
}
