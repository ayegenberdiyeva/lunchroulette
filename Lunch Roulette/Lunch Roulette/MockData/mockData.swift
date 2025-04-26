//
//  mockData.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

let mockSpots: [LunchSpot] = [
    LunchSpot(
        id: UUID().uuidString,
        name: "Sakura Sushi",
        cuisine: .japanese,
        averageBill: 12000,
        waitingTime: 15
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Bella Italia",
        cuisine: .italian,
        averageBill: 18000,
        waitingTime: 20
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Chopan",
        cuisine: .national,
        averageBill: 8000,
        waitingTime: 30
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Maison de Paris",
        cuisine: .french,
        averageBill: 25000,
        waitingTime: 45
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Bosphorus Grill",
        cuisine: .turkish,
        averageBill: 15000,
        waitingTime: 60
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Han Kuk",
        cuisine: .korean,
        averageBill: 10000,
        waitingTime: 15
    )
]
