//
//  DetailViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/8/23.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var orderItem: OrderItem = OrderItem(title: "", totalPrice: "", selectedAdditions: [])
    @Published var foodModelChanged = false
    @Published var totalPrice: String = "0"
    @Published var isDragble = true
    @Published var viewState: CGSize = .zero
    @Published var appear = [false, false, false, false]
    @Published var count: Int = 1
    
    func calculateWith(foodItem: Food) {
        var total: Double = 0
        
        guard let price = Double(foodItem.price) else {
            fatalError("foodItem.price ->> doesn't exist or the value format is not correct")
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
        total *= Double(count)
        totalPrice = String(format: "%.2f", total)
    }
    
    func foodHasBeenChanged() {
        foodModelChanged = true
    }
    
    func addItemToCart(item: Food) {
        let title = item.title
        let totalPrice = self.totalPrice
        var additions = [Addition]()
        for addtion in item.options {
            
        }
    }
}
