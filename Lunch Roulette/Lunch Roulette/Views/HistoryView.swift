//
//  HistoryView.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import SwiftUI

struct HistoryView: View {
    let spots: [LunchSpot]
    
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
                if !spots.isEmpty {
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
            Text("\(String(format: "%.1f", spot.ratingDouble ?? 0.0)) | \(spot.cuisine.name) | \(spot.waitingTime) мин")
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

//#Preview {
////    NavigationStack{
////        HistoryView(spots: nil)
////        HistoryView(spots: [])
////        HistoryView(spots: [LunchSpot(id: "1", name: "Test", cuisine: .chinese, averageBill: 123, waitingTime: 12, rating: 4.5, ratingCount: 200, address: "Test Test", workingTill: "23:00", mapUrl: "test", menuUrl: "test")])
////    }
//    HistoryView(spots: LunchHistoryManager.shared.load())
//}


#Preview {
     // Создаем моковые данные для превью HistoryView
     let mockCuisine1 = Cuisine(id: 1, name: "Японская", slug: "japanese", emoji: "🍣")
     let mockSpot1 = LunchSpot(
         id: 101, name: "Sakura Sushi", cuisine: mockCuisine1, averageBill: "12000.00",
         waitingTime: 15, rating: "4.5", ratingCount: 100, address: "...",
         workingTill: "23:00", mapUrl: "...", menuUrl: "..."
     )

     let mockCuisine2 = Cuisine(id: 2, name: "Итальянская", slug: "italian", emoji: "🍝")
     let mockSpot2 = LunchSpot(
         id: 102, name: "Bella Italia", cuisine: mockCuisine2, averageBill: "18000.00",
         waitingTime: 20, rating: "3.8", ratingCount: 200, address: "...",
         workingTill: "22:00", mapUrl: "...", menuUrl: "..."
     )

    // Передаем моковые данные в HistoryView
    return NavigationStack{ // Оборачиваем в NavigationStack для корректной работы NavigationLink
         HistoryView(spots: [mockSpot1, mockSpot2])
     }
}
