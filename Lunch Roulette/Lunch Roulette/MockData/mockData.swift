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
        waitingTime: 15,
        rating: 4.5,
        ratingCount: 100,
        address: "Almaty, Nazarbayev ave 123",
        workingTill: "23:00",
        mapUrl: "https://2gis.kz/almaty/geo/70000001088050245",
        menuUrl: "https://okadzaki.kz/"
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Bella Italia",
        cuisine: .italian,
        averageBill: 18000,
        waitingTime: 20,
        rating: 3.8,
        ratingCount: 200,
        address: "Almaty, Kairbekov str 456",
        workingTill: "22:00",
        mapUrl: "https://2gis.kz/almaty/geo/70000001088050245",
        menuUrl: "https://okadzaki.kz/"
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Chopan",
        cuisine: .national,
        averageBill: 8000,
        waitingTime: 30,
        rating: 4.2,
        ratingCount: 100,
        address: "Almaty, Kairbekov str 456",
        workingTill: "22:00",
        mapUrl: "https://2gis.kz/almaty/geo/70000001088050245",
        menuUrl: "https://okadzaki.kz/"
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Maison de Paris",
        cuisine: .french,
        averageBill: 25000,
        waitingTime: 45,
        rating: 2.9,
        ratingCount: 500,
        address: "Almaty, Kairbekov str 456",
        workingTill: "21:30",
        mapUrl: "https://2gis.kz/almaty/geo/70000001088050245",
        menuUrl: "https://okadzaki.kz/"
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Bosphorus Grill",
        cuisine: .turkish,
        averageBill: 15000,
        waitingTime: 60,
        rating: 4.7,
        ratingCount: 100,
        address: "Almaty, Kairbekov str 456",
        workingTill: "22:00",
        mapUrl: "https://2gis.kz/almaty/geo/70000001088050245",
        menuUrl: "https://okadzaki.kz/"
    ),
    LunchSpot(
        id: UUID().uuidString,
        name: "Han Kuk",
        cuisine: .korean,
        averageBill: 10000,
        waitingTime: 15,
        rating: 3.5,
        ratingCount: 200,
        address: "Almaty, Kairbekov str 456",
        workingTill: "23:00",
        mapUrl: "https://2gis.kz/almaty/geo/70000001088050245",
        menuUrl: "https://okadzaki.kz/"
    )
]
