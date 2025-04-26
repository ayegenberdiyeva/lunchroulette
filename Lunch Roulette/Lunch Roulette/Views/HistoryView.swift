//
//  HistoryView.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import SwiftUI

struct HistoryView: View {
    let spots: [LunchSpot]!

    var body: some View {
        List(spots.reversed()) { spot in
            NavigationLink(destination: LunchCard(spot: spot)){
                VStack(alignment: .leading) {
                    Text(spot.name)
                        .font(.headline)
                    Text("\(spot.cuisine.rawValue) • $\(spot.averageBill, specifier: "%.2f") • \(spot.waitingTime) min")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
//            VStack(alignment: .leading) {
//                Text(spot.name)
//                    .font(.headline)
//                Text("\(spot.cuisine.rawValue) • $\(spot.averageBill, specifier: "%.2f") • \(spot.waitingTime) min")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
//            }
        }
        .navigationTitle("History")
    }
}

#Preview {
    HistoryView(spots: LunchHistoryManager.shared.load())
}
