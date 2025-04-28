//
//  LunchViewModel.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation
import Combine
import SwiftUI

class LunchViewModel: ObservableObject {
    @Published var currentSpot: LunchSpot? = nil
    @Published var history: [LunchSpot] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let historyManager = LunchHistoryManager.shared
    private let networkManager = NetworkManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadHistory()
    }
    
    func loadHistory() {
        self.history = historyManager.load() ?? []
    }
    
    private func addToHistory(_ spot: LunchSpot) {
        if !history.contains(where: { $0.id == spot.id }) {
            if history.count >= 20 {
                history.removeFirst()
            }
            history.append(spot)
            historyManager.save(history)
        }
    }
            
    func fetchRandomSpot(
        selectedPriceRange: PriceRange?,
        selectedCuisines: [CuisineFilterType]?,
        selectedMaxWaitingTime: Int?
    ) {
        isLoading = true
        errorMessage = nil
        currentSpot = nil
        
        let priceKey = selectedPriceRange?.apiKey
        let cuisineSlugs = selectedCuisines?
            .compactMap { $0.slug }
            .filter { !$0.isEmpty }
        
        networkManager.fetchRandomLunchSpot(
            priceRangeKey: priceKey,
            cuisineSlugs: cuisineSlugs,
            maxWaitingTime: selectedMaxWaitingTime
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let spot):
                    self?.currentSpot = spot
                    self?.addToHistory(spot)
                    self?.errorMessage = nil
                case .failure(let error):
                    if let networkError = error as? NetworkError {
                        switch networkError {
                        case .notFound(let message):
                            self?.errorMessage = message
                        default:
                            self?.errorMessage = networkError.localizedDescription // Используем общее описание ошибки
                        }
                    } else {
                        self?.errorMessage = error.localizedDescription
                    }
                    print("Error received in ViewModel: \(self?.errorMessage ?? "Unknown error")") // Отладка
                    self?.currentSpot = nil
                }
            }
        }
    }
    
}
