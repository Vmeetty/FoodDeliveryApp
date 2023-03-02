//
//  CoinViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

class CoinViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    
    @MainActor
    func fetchCoins() async {
        if let url = URL(string: "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10") {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                coins = try JSONDecoder().decode([Coin].self, from: data)
            } catch {
                print("Error fetching coins >>")
            }
        }
    }
}
