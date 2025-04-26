//
//  SpotFilter.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import Foundation

struct SpotFilter {
    var budgetRange: PriceRange? = nil
    var selectedCuisines: [Cuisine] = []
    var maxWaitingTime: Int? = nil
}
