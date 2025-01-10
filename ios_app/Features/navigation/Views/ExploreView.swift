//
//  ExploreView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//

import SwiftUI

struct ExploreView: View {
    let studentId: UUID // Add a property to hold the student ID

    var body: some View {
        SwipeableCardsView(studentId: studentId) // Pass the student ID to SwipeableCardsView
    }
}
