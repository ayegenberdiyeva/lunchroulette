//
//  Cuisine.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 28.04.2025.
//

import Foundation

struct Cuisine: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let slug: String
    let emoji: String?
}
