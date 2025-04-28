//
//  LunchSpot.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

struct LunchSpot: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let cuisine: Cuisine
    let averageBill: String
    let waitingTime: Int
    let rating: String
    let ratingCount: Int
    let address: String
    let workingTill: String
    let mapUrl: String
    let menuUrl: String
    
    var averageBillDouble: Double? {
        Double(averageBill)
    }

    var ratingDouble: Double? {
        Double(rating)
    }
    
    var ratingEmoji: String {
        guard let ratingValue = ratingDouble else { return "😔" }
        switch ratingValue {
          case 4.5...5.0: return "😍"
          case 3.5..<4.5: return "😄"
          case 2.5..<3.5: return "🙂"
          case 1.5..<2.5: return "😐"
          case 0.5..<1.5: return "😕"
          default: return "😔"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case cuisine
        case averageBill = "average_bill" // Соответствует ключу в JSON
        case waitingTime = "waiting_time"
        case rating
        case ratingCount = "rating_count"
        case address
        case workingTill = "working_till"
        case mapUrl = "map_url"
        case menuUrl = "menu_url"
    }
}
