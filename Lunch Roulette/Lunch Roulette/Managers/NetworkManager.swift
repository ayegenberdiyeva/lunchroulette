//
//  NetworkManager.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 28.04.2025.
//

import Foundation
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://127.0.0.1:8000/api/"
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRandomLunchSpot(
            priceRangeKey: String?,
            cuisineSlugs: [String]?,
            maxWaitingTime: Int?,
            completion: @escaping (Result<LunchSpot, Error>) -> Void
    ) {
        guard var components = URLComponents(string: baseURL + "lunch_spots/") else {
            print("Error: Invalid base URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "random", value: "true"))

        if let priceKey = priceRangeKey, !priceKey.isEmpty {
            queryItems.append(URLQueryItem(name: "price_range", value: priceKey))
        }

        if let slugs = cuisineSlugs, !slugs.isEmpty {
            slugs.forEach { slug in
                queryItems.append(URLQueryItem(name: "cuisine__slug", value: slug))
            }
        }

        if let time = maxWaitingTime, time > 0 {
            queryItems.append(URLQueryItem(name: "max_waiting_time", value: String(time)))
        }

        components.queryItems = queryItems

        guard let url = components.url else {
        print("Error: Could not create URL with components: \(components)")
        completion(.failure(NetworkError.invalidURL))
        return
        }

        print("Fetching URL: \(url.absoluteString)")

        URLSession.shared.dataTaskPublisher(for: url)
        .tryMap { data, response -> Data in
           guard let httpResponse = response as? HTTPURLResponse else {
               throw NetworkError.invalidResponse
           }
           print("Response status code: \(httpResponse.statusCode)")
           guard (200...299).contains(httpResponse.statusCode) else {
               if let errorDetail = try? JSONDecoder().decode(ErrorDetail.self, from: data) {
                    print("API Error Detail: \(errorDetail.detail)")
                    if httpResponse.statusCode == 404 {
                        throw NetworkError.notFound(errorDetail.detail)
                    } else {
                        throw NetworkError.apiError(message: errorDetail.detail, statusCode: httpResponse.statusCode)
                    }
               } else {
                    throw NetworkError.serverError(statusCode: httpResponse.statusCode)
               }
           }
            print("Raw Response Data: \(String(data: data, encoding: .utf8) ?? "Could not decode data")") // Отладка
           return data
        }
        .decode(type: LunchSpot.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { resultCompletion in
           switch resultCompletion {
           case .failure(let error):
               print("Error fetching random spot: \(error)")
               if let networkError = error as? NetworkError {
                   completion(.failure(networkError))
               } else if let decodingError = error as? DecodingError {
                    print("Decoding Error: \(decodingError)")
                   completion(.failure(NetworkError.decodingError(decodingError)))
               }
               else {
                   completion(.failure(error))
               }
           case .finished:
               break
           }
        }, receiveValue: { lunchSpot in
           completion(.success(lunchSpot))
        })
        .store(in: &cancellables)
   }
}



struct ErrorDetail: Decodable {
    let detail: String
}
