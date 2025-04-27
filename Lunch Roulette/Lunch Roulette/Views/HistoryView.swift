//
//  HistoryView.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import SwiftUI

struct HistoryView: View {
    let spots: [LunchSpot]?
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action:{
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("Lunch Roulette")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top)
            
            
            Group {
                if let spots = spots, !spots.isEmpty {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(spots.reversed(), id: \.id) { spot in
                                NavigationLink(destination: LunchCard(spot: spot, scourceView: .history)) {
                                    HistoryItemView(spot: spot)
                                }
                            }
                        }
                        .padding()
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("История пуста")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
            }
        }
        .padding(.horizontal, 25)
        .padding(.top, 20)
        .navigationBarBackButtonHidden()
        .navigationTitle("История")
    }
}

struct HistoryItemView: View {
    let spot: LunchSpot
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(spot.name)
                .font(.headline)
            Text("\(spot.rating, specifier: "%.1f") | \(spot.cuisine.rawValue) | \(spot.waitingTime) мин")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.orange.opacity(0.2), radius: 2, x: 0, y: 0)
        )
        .foregroundColor(.primary)
    }
}

#Preview {
//    NavigationStack{
//        HistoryView(spots: nil)
//        HistoryView(spots: [])
//        HistoryView(spots: [LunchSpot(id: "1", name: "Test", cuisine: .chinese, averageBill: 123, waitingTime: 12, rating: 4.5, ratingCount: 200, address: "Test Test", workingTill: "23:00", mapUrl: "test", menuUrl: "test")])
//    }
    HistoryView(spots: LunchHistoryManager.shared.load())
}
