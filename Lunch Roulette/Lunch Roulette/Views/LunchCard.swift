//
//  LunchCard.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import SwiftUI

struct LunchCard: View {
//    let spotList: [LunchSpot]
    let spot: LunchSpot
    
    var body: some View {
//        let spot: LunchSpot! = spotList.randomElement()
        VStack(alignment: .leading, spacing: 8) {
            Text(spot.name)
                .font(.title2)
                .bold()
            Text("Cuisine: \(spot.cuisine)")
            Text("Average bill: $\(spot.averageBill, specifier: "%.2f")")
            Text("Waiting time: \(spot.waitingTime) min")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    LunchCard(spot: mockSpots[0])
}
