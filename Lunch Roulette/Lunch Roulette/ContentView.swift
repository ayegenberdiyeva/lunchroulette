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
    @State private var searchAttemted: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                HStack {
                    
                    VStack{
                        SectionTitle(title: "Средний чек")
                            .frame(alignment: .top)
                         FlowButtons(options: PriceRange.allCases.map {$0.rawValue},
                                     selected: selectedPrice.rawValue,
                                     action: { value in
                                         if let price = PriceRange(rawValue: value) {
                                             selectedPrice = price
                                         }
                                     })
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Divider()
                    
                    VStack{
                        SectionTitle(title: "Кухня")
                        FlowButtons(options: Cuisine.allCases.map { $0.rawValue},
                                    selected: selectedCuisines.map { $0.rawValue},
                                    multiSelect: true,
                                    action: { value in
                            if let cuisine = Cuisine(rawValue: value) {
                                if selectedCuisines.contains(cuisine) {
                                    selectedCuisines.removeAll { $0 == cuisine }
                                } else {
                                    selectedCuisines.append(cuisine)
                                }
                            }
                        })
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                SectionTitle(title: "Время ожидания")
                WaitingTimePicker(selected: $selectedWaitingTime)
                
                Button(action: {
                    searchAttemted = true
                    
                    vm.fetchRandomSpot(
                        selectedPriceRange: selectedPrice,
                        selectedCuisines: selectedCuisines,
                        selectedMaxWaitingTime: selectedWaitingTime
                    )
                    if let spot = vm.currentSpot {
                        selectedSpot = spot
                    }
                }) {
                    Text("ВЫБРАТЬ ЗАВЕДЕНИЕ")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .cornerRadius(16)
                }
                .padding(.top)
                
                
                if searchAttemted && vm.currentSpot == nil {
                    Text("Упс! Пока что нет заведения по вашим предпочтениям")
                        .foregroundColor(.gray)
                        .padding(.top, 8)

                }

                NavigationLink("посмотреть историю") {
                    HistoryView(spots: vm.history)
                }
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.top, 8)
                    .underline(true)
                    .frame(alignment: .bottom)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Lunch Roulette")
            .navigationDestination(item: $selectedSpot) {
                spot in LunchCard(spot: spot, scourceView: .random)
            }
        }
    }
}

struct SectionTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
    }
}

struct FlowButtons: View {
    var options: [String]
    var selected: [String]
    var multiSelect = false
    var action: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200))], spacing: 8) {
            VStack(spacing: 8) {
                ForEach(options, id: \.self) { option in
                    Button(action: { action(option) }) {
                        Text(option)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 15)
                            .background(selected.contains(option) ? Color.orange : Color.gray.opacity(0.2))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    init(options: [String], selected: String, multiSelect: Bool = false, action: @escaping (String) -> Void) {
        self.options = options
        self.selected = [selected]
        self.multiSelect = multiSelect
        self.action = action
    }

    init(options: [String], selected: [String], multiSelect: Bool = true, action: @escaping (String) -> Void) {
        self.options = options
        self.selected = selected
        self.multiSelect = multiSelect
        self.action = action
    }
}

struct WaitingTimePicker: View {
    @Binding var selected: Int
    let options = [15, 30, 45, 60]

    var body: some View {
        HStack(spacing: 16) {
            ForEach(options, id: \.self) { time in
                Button(action: {
                    selected = time
                }) {
                    Text(time == 60 ? "Более 60 мин" : "\(time) мин")
                        .font(.subheadline)
                        .padding(18)
                        .frame(width: 80)
                        .overlay(
                            Circle()
                                .stroke(selected == time ? Color.orange : Color.gray, lineWidth: 2)
                        )
                }
                .foregroundColor(.black)
            }
        }
    }
}


#Preview {
    ContentView()
}
