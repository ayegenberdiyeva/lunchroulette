//
//  LunchHistoryManager.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

class LunchHistoryManager {
    static let shared = LunchHistoryManager()
    private let filename = "lunchHistory.json"
    
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
    
    func save(_ spots: [LunchSpot]) {
        do {
            let data = try JSONEncoder().encode(spots)
            try data.write(to: fileURL)
        } catch {
            print("Error saving: \(error.localizedDescription)")
        }
    }
    
    func load() -> [LunchSpot]? {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([LunchSpot].self, from: data)
        } catch {
            print("Error loading: \(error.localizedDescription)")
            return []
        }
    }
}
