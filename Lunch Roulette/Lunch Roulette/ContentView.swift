//
//  ContentView.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 25.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = LunchViewModel()
    @State var selectedPrice: PriceRange = .low
    @State var selectedCuisines: [Cuisine] = []
    @State var selectedWaitingTime: Int = 15
    
    @State private var isNavigating = false
    @State private var selectedSpot: LunchSpot? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                VStack(alignment: .leading) {
                    Text("Price range")
                        .font(.title)
                    Picker("Price", selection: $selectedPrice) {
                        ForEach(PriceRange.allCases) { price in Text(price.rawValue).tag(price)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                VStack(alignment: .leading){
                    Text("Cousine")
                        .font(.title)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 10) {
                            ForEach(Cuisine.allCases) { cuisine in
                                Button(action: {
                                    if selectedCuisines.contains(cuisine) {
                                        selectedCuisines.removeAll { $0 == cuisine }
                                    } else {
                                        selectedCuisines.append(cuisine)
                                    }
                                }) {
                                    Text(cuisine.rawValue)
                                        .padding(8)
                                        .frame(maxWidth: .infinity)
                                        .background(selectedCuisines.contains(cuisine) ? Color.blue : Color.gray.opacity(0.3))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                            }
                        }
                }
                
                VStack(alignment: .leading) {
                    Text("Waiting time")
                        .font(.title)
                    Picker("Time", selection: $selectedWaitingTime) {
                        ForEach([15, 30, 45, 60], id: \.self) {
                            i in Text("\(i) minutes").tag(i)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                // Filter
                

//                 Button
                
                
                
                Button("Get Lunch Place") {
                    vm.fetchRandomSpot(
                        selectedPriceRange: selectedPrice,
                        selectedCuisines: selectedCuisines,
                        selectedMaxWaitingTime: selectedWaitingTime
                    )
                    if let spot = vm.currentSpot {
                        selectedSpot =  spot
                    }
                }
                .buttonStyle(.borderedProminent)

                // Show result
//                if let spot = vm.currentSpot {
//                    LunchCard(spot: spot)
//                }

                NavigationLink("View History") {
                    HistoryView(spots: vm.history)
                }
                .padding(.top)
            }
            .padding()
            .navigationTitle("Lunch Roulette")
            .navigationDestination(item: $selectedSpot) {
                spot in LunchCard(spot: spot)
            }
        }
    }
}

#Preview {
    ContentView()
}
