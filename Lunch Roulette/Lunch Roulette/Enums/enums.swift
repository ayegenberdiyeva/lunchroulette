//
//  enums.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

enum Cuisine: String, Codable, CaseIterable, Identifiable {
    case national = "Национальная"
    case korean = "Корейская"
    case japanese = "Японская"
    case chinese = "Китайская"
    case italian = "Итальянская"
    case french = "Французская"
    case turkish = "Турецкая"
    
    var id : Self { self }
    
    var string: String {
        switch self {
            case .national:
                return "National"
            case .korean:
                return "Korean"
            case .japanese:
                return "Japanese"
            case.chinese:
                return "Chinese"
            case .italian:
                return "Italian"
            case .french:
                return "French"
            case .turkish:
                return "Turkish"
        }
    }
    
    var emoji: String {
        switch self {
            case .national:
                return "🍲"
            case .korean:
                return "🍚"
            case .japanese:
                return "🍣"
            case .chinese:
                return "🥡"
            case .italian:
                return "🍝"
            case .french:
                return "🥖"
            case .turkish:
                return "🥙"
        }
    }
}

enum PriceRange: String, CaseIterable, Identifiable {
    case low = "Менее 5.000"
    case medium = "5.000 - 12.000"
    case high = "12.000 - 25.000"
    case luxury = "25.000 и более"
    
    var id: Self { self }
    
    var range: ClosedRange<Double> {
        switch self {
        case .low:
            return 0...5000
        case .medium:
            return 5000...12000
        case .high:
            return 12000...25000
        case .luxury:
            return 25000...Double.infinity
        }
    }
}

enum ScourceView {
    case history
    case random
}
