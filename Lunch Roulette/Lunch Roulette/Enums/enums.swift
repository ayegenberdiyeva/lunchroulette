//
//  enums.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

enum Cuisine: String, Codable, CaseIterable, Identifiable {
    case national = "National"
    case korean = "Korean"
    case japanese = "Japanese"
    case chinese = "Chinese"
    case italian = "Italian"
    case french = "French"
    case turkish = "Turkish"
    
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
}

enum PriceRange: String, CaseIterable, Identifiable {
    case low = "<5000"
    case medium = "5000-12000"
    case high = "12000-25000"
    case luxury = "25000<"
    
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
