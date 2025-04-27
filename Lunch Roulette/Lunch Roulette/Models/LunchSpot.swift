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
    let rating: Double
    let ratingCount: Int
    let address: String
    let workingTill: String
    let mapUrl: String
    let menuUrl: String
    
    }

extension LunchSpot {
    var ratingEmoji: String {
        switch rating {
            case 4.5...5.0: return "😍"
            case 3.5..<4.5: return "😄"
            case 2.5..<3.5: return "🙂"
            case 1.5..<2.5: return "😐"
            case 0.5..<1.5: return "😕"
        default: return "😔"
        }
    }
}
