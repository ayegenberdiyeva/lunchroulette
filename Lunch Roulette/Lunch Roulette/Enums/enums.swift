//
//  enums.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

enum CuisineFilterType: String, Codable, CaseIterable, Identifiable {
    case all = "Все"
    case national = "Национальная"
    case korean = "Корейская"
    case japanese = "Японская"
    case chinese = "Китайская"
    case italian = "Итальянская"
    case french = "Французская"
    case turkish = "Турецкая"
    
    var id : String { self.rawValue }
    
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
            default :
            return "All"
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
        default:
            return "😋"
        }
    }
    
    var slug: String {
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
            case .all:
                return ""
        }
    }
}

enum PriceRange: String, CaseIterable, Identifiable {
    case null = ""
    case low = "Менее 5.000"
    case medium = "5.000 - 12.000"
    case high = "12.000 - 25.000"
    case luxury = "25.000 и более"
    
    var id: Self { self }
    
    var range: ClosedRange<Double> {
        switch self {
        case .low:
            return 1...5000
        case .medium:
            return 5000...12000
        case .high:
            return 12000...25000
        case .luxury:
            return 25000...Double.infinity
            default :
            return 0...Double.infinity
        }
    }
    
    var apiKey: String? {
        switch self {
        case .low: return "low"
        case .medium: return "medium"
        case .high: return "high"
        case .luxury: return "luxury"
        case .null: return nil
        }
    }

}

enum ScourceView {
    case history
    case random
}


enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError(statusCode: Int)
    case apiError(message: String, statusCode: Int)
    case notFound(String) // Отдельно для 404
    case decodingError(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Некорректный URL запроса."
        case .invalidResponse: return "Получен некорректный ответ от сервера."
        case .serverError(let code): return "Ошибка сервера (код: \(code)). Попробуйте позже."
        case .apiError(let message, let code): return "Ошибка API (код: \(code)): \(message)"
        case .notFound(let message): return message // Используем сообщение от API
        case .decodingError(let error): return "Ошибка декодирования данных: \(error.localizedDescription)"
        case .unknown(let error): return "Неизвестная ошибка: \(error.localizedDescription)"
        }
    }
}
