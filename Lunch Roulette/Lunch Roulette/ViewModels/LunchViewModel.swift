//
//  LunchViewModel.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

class LunchViewModel: ObservableObject {
    @Published var currentSpot: LunchSpot?
    @Published var history: [LunchSpot] = []
    
    private let allSpots: [LunchSpot] = mockSpots
 
    init() {
        history = LunchHistoryManager.shared.load() ?? []
    }
    
    func fetchRandomSpot(selectedPriceRange: PriceRange?, selectedCuisines: Array<Cuisine>?, selectedMaxWaitingTime: Int?) {
        let filter = SpotFilter(
            budgetRange: selectedPriceRange,
            selectedCuisines: selectedCuisines ?? [],
            maxWaitingTime: selectedMaxWaitingTime
        )
        
        let filteredSpots = allSpots.filter { spot in
            (filter.budgetRange?.range.contains(spot.averageBill) ?? true) &&
            (filter.selectedCuisines.isEmpty || filter.selectedCuisines.contains(spot.cuisine)) &&
            (filter.maxWaitingTime.map { spot.waitingTime <= $0 } ?? true)
        }
        
        if let spot = filteredSpots.randomElement() {
            currentSpot = spot
            history.append(spot)
            LunchHistoryManager.shared.save(history)
        }
        
    }
}
