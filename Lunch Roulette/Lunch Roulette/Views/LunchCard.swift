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
                        VStack(){
                            Text("\(spot.rating, specifier: "%.1f")")
                                .frame(maxWidth: .infinity,
                                       alignment: .leading)
                                .bold()
                                .font(.title3)
                            Text("+\(spot.ratingCount) отзывов")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(.gray)
                                .font(.caption2)
                        }
                    }
                }
                Divider()
                HStack(){
                    Text("🕑")
                        .font(.largeTitle)
                    VStack(){
                        Text("\(spot.waitingTime) мин")
                            .frame(maxWidth: .infinity,
                                   alignment: .leading)
                            .bold()
                            .font(.title3)
                    }
                }
            }
            .font(.title)
            .padding(.vertical, 8)
            .frame(maxHeight: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(spot.address)
                Text("открыто до \(spot.workingTill)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Link(destination: URL(string: spot.mapUrl)!) {
                    Text("посмотреть на карте")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
            }
            .padding()
            .frame(maxWidth: .infinity,
                   alignment: .leading)
            .background(Color.gray.opacity(0.3).cornerRadius(16))
            
            Text("\(spot.cuisine.emoji) \(spot.cuisine.rawValue)")
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .foregroundColor(.black)
            
            Divider()
            
            HStack {
                Text("Средний чек")
                    .font(.headline)
                Spacer()
                Text("₸\(spot.averageBill, specifier: "%.f")")
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
    LunchCard(spot: mockSpots[0], scourceView: .random)
}
