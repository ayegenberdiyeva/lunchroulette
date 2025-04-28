//
//  ContentView.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 25.04.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = LunchViewModel()
    @State var selectedPrice: PriceRange = .null
    @State var selectedCuisines: [CuisineFilterType] = []
    @State var selectedWaitingTime: Int = 15
    
    @State private var navigateToSpot: LunchSpot? = nil
    @State private var showMissingFiltersAlert: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                VStack {
                    
                    VStack{
                        SectionTitle(title: "Средний чек")
                         FlowButtons(options: PriceRange.allCases.map {$0.rawValue},
                                     selected: selectedPrice.rawValue,
                                     action: { value in
                                         if let price = PriceRange(rawValue: value) {
                                             selectedPrice = price
                                         }
                                     })
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack{
                        SectionTitle(title: "Кухня")
                        FlowButtons(options: CuisineFilterType.allCases.map { $0.rawValue},
                                    selected: selectedCuisines.map { $0.rawValue},
                                    multiSelect: true,
                                    action: { value in
                            if let cuisine = CuisineFilterType(rawValue: value) {
                                if selectedCuisines.contains(cuisine) {
                                    selectedCuisines.removeAll { $0 == cuisine }
                                } else {
                                    selectedCuisines.append(cuisine)
                                }
                            }
                        })
                    }
                }
                
                SectionTitle(title: "Время ожидания")
                WaitingTimePicker(selected: $selectedWaitingTime)
                
                VStack{
                    Button(action: {
                        if selectedPrice == .null || selectedCuisines.isEmpty || selectedWaitingTime == 0 {
                            showMissingFiltersAlert = true
                        } else {
                            vm.fetchRandomSpot(
                                selectedPriceRange: selectedPrice,
                                selectedCuisines: selectedCuisines,
                                selectedMaxWaitingTime: selectedWaitingTime == 60 ? nil : selectedWaitingTime
                            )
                        }
                    }) {
                        if vm.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange.opacity(0.7))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .cornerRadius(16)
                        } else {
                            Text("ВЫБРАТЬ ЗАВЕДЕНИЕ")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .cornerRadius(16)
                        }
                    }
                    .disabled(vm.isLoading)
                    .padding(.top, 50)
                    .alert("Подождите", isPresented: $showMissingFiltersAlert) {
                        Button("ОК", role: .cancel) { }
                    } message: {
                         Text("Выберите все фильтры перед поиском.")
                    }
                    
                    .alert("Ошибка", isPresented: .constant(vm.errorMessage != nil), actions: {
                        Button("ОК", role: .cancel) { vm.errorMessage = nil }
                    }, message: {
                         Text(vm.errorMessage ?? "Произошла неизвестная ошибка.")
                    })
                    
                    .onChange(of: vm.currentSpot) { newSpot, oldSpot in
                         if newSpot != nil {
                              navigateToSpot = newSpot
                         }
                    }

                    NavigationLink("посмотреть историю") {
                        HistoryView(spots: vm.history)
                    }
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .underline(true)
                    .padding(.top, 10)
                    
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Lunch Roulette")
            .navigationDestination(item: $navigateToSpot) { spot in
                  LunchCard(spot: spot, scourceView: .random)
             }
        }
        .onAppear {
              vm.loadHistory() 
         }
    }
}

struct SectionTitle: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 25)
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
            
            ScrollView(.horizontal){
                HStack(spacing: 8) {
                    ForEach(options, id: \.self) { option in
                        Button(action: { action(option) }) {
                            Text(option)
                                .padding(.vertical, 7)
                                .padding(.horizontal, 10)
                                .background(selected.contains(option) ? Color.orange : Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                                .lineLimit(1)
                        }
                        .padding(2)
                    }
                }
            }
            .padding(.bottom, 25)
            
            Divider()
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
