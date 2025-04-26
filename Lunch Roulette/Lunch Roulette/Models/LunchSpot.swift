//
//  LunchSpot.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

struct LunchSpot: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let cuisine: Cuisine
    let averageBill: Double
    let waitingTime: Int
}
