//
//  CardModel.swift
//  ios_app
//
//  Created by Kenny Morales on 1/10/25.
//

import Foundation

struct CardModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let subtitle: String
}

enum CardSwipeDirection {
    case left, right, up
}
