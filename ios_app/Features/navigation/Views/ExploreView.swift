//
//  ExploreView.swift
//  ios_app
//
//  Created by Wilson Overfield on 1/7/25.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        VStack {
            // Mock data for the cards
            let mockCards: [ExploreCard.Model] = [
                ExploreCard.Model(
                    school: School(
                        id: 1,
                        name: "University of Nebraska-Lincoln",
                        city: "Lincoln",
                        state: "NE",
                        size: 19189,
                        averageSAT: 25.0,
                        coaAcademicYear: 2025
                    ),
                    swipeDirection: .none
                ),
                ExploreCard.Model(
                    school: School(
                        id: 2,
                        name: "University of California, Berkeley",
                        city: "Berkeley",
                        state: "CA",
                        size: 41900,
                        averageSAT: 1415,
                        coaAcademicYear: 2025
                    ),
                    swipeDirection: .none
                ),
                ExploreCard.Model(
                    school: School(
                        id: 3,
                        name: "Harvard University",
                        city: "Cambridge",
                        state: "MA",
                        size: 21000,
                        averageSAT: 1520,
                        coaAcademicYear: 2025
                    ),
                    swipeDirection: .none
                ),
            ]

            // Initialize model with the mock cards
            let model = SwipeableCards.Model(cards: mockCards)

            SwipeableCards(model: model) { model in
                print(model.swipedCards)
                model.reset()  // Reset the cards after swipe
            }
        }
        .background(Color("surface"))
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
