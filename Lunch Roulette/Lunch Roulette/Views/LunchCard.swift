//
//  LunchCard.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import SwiftUI

struct LunchCard: View {
    let spot: LunchSpot
    let scourceView: ScourceView
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action:{
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text(titleText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top)
            
            Text(spot.name)
               .font(.largeTitle.bold())
               .frame(maxWidth: .infinity, alignment: .leading)
               .padding(.top, 40)
        
            
            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    HStack(){
                        Text(spot.ratingEmoji)
                            .font(.largeTitle)
                            .padding(.leading, 20)
                        VStack(alignment: .leading){
                            Text("\(spot.ratingDouble ?? 0.0, specifier: "%.1f")")
                                .bold()
                                .font(.title3)
                            Text("+\(spot.ratingCount) отзывов")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Divider()
                HStack(){
                    Text("🕑")
                        .font(.largeTitle)
                    VStack(alignment: .leading){
                        Text("\(spot.waitingTime) мин")
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .bold()
                            .font(.title3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .font(.title)
            .padding(.vertical, 8)
            .frame(maxHeight: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(spot.address)
                    .font(.body)
                Text("открыто до \(spot.workingTill)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if let url = URL(string: spot.mapUrl) {
                    Link(destination: url) {
                        Text("посмотреть на карте")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                     }
                } else {
                    Text("Некорректный URL карты")
                        .foregroundColor(.red)
                }
            }
            .padding()
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .background(Color.gray.opacity(0.15).cornerRadius(16))
            
            Text("\(spot.cuisine.emoji ?? "🍽️") \(spot.cuisine.name)")
                .font(.headline)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .foregroundColor(.black)
                .background(Color.orange.opacity(0.2).cornerRadius(8))
                                .foregroundColor(.black)
            
            Divider()
            
            HStack {
                Text("Средний чек")
                    .font(.headline)
                Spacer()
                    Text("₸\(String(format: "%.0f", spot.averageBillDouble ?? 0))")
            }
            
            Link(destination: URL(string: spot.menuUrl)!) {
                Text("посмотреть меню")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            Spacer()
            
        }
        .padding(.horizontal, 25)
        .padding(.top, 20)
        .navigationBarBackButtonHidden()
        
    }
    
    private var titleText: String {
        switch scourceView {
        case .history:
            return "Предыдущие места"
        case .random:
            return "Вам выпало..."
        }
    }
}

#Preview {
     // Создаем моковые данные с новой структурой
     let mockCuisine = Cuisine(id: 1, name: "Японская", slug: "japanese", emoji: "🍣")
     let mockSpot = LunchSpot(
         id: 101,
         name: "Sakura Sushi",
         cuisine: mockCuisine,
         averageBill: "12000.00",
         waitingTime: 15,
         rating: "4.5",
         ratingCount: 100,
         address: "Almaty, Nazarbayev ave 123",
         workingTill: "23:00",
         mapUrl: "https://2gis.kz/almaty/geo/70000001088050245",
         menuUrl: "https://okadzaki.kz/"
     )
    return LunchCard(spot: mockSpot, scourceView: .random)
}
