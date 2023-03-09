//
//  DetailViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/8/23.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var orderItem: OrderItem = OrderItem(title: "", price: "", selectedAdditions: [])
    @Published var foodModelChanged = false
    @Published var totalPrice: String = "0"
    
    func calculateWith(foodItem: Food) {
        var total: Double = 0
        
        guard let price = Double(foodItem.price) else {
            fatalError("orderItem.price ->> doesn't exist or the value format is not correct")
        }
        total += price
        
        for addition in foodItem.options {
            for addItem in addition.values {
                if addItem.isSelected {
                    if let addItemPrice = addItem.price {
                        guard let safeAddItemPrice = Double(addItemPrice) else {
                            fatalError("addItem.price ->> value format is not correct")
                        }
                        total += safeAddItemPrice
                    }
                }
            }
        }
        totalPrice = String(total)
    }
    
    func foodHasBeenChanged() {
        foodModelChanged = true
    }
}
