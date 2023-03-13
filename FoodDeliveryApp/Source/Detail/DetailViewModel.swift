//
//  DetailViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/8/23.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var orderItem = Food(title: "", weight: "", text: "", image: "", price: 0.0, category: "", options: [], countSelected: 0)
    @Published var foodModelChanged = false
    @Published var totalPrice: Double = 0.0
    @Published var isDragble = true
    @Published var viewState: CGSize = .zero
    @Published var appear = [false, false, false, false]
    @Published var count: Int = 1
    @Published var localDishItem = Food(title: "", weight: "", text: "", image: "", price: 0.0, category: "", options: [], countSelected: 0)
    
    func createLocalItem(food: Food) {
        localDishItem = Food(
            id: food.id,
            title: food.title,
            weight: food.weight,
            text: food.text,
            image: food.image,
            price: food.price,
            category: food.category,
            options: food.options,
            countSelected: 0
        )
        totalPrice = food.price
    }
    
    func calculateWith() {
        var total: Double = 0
        total += localDishItem.price

        for addition in localDishItem.options {
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
        totalPrice = total // String(format: "%.2f", total)
    }
    
    func foodHasBeenChanged() {
        foodModelChanged = true
    }
    
    func addItemToCart(item: Food) {
        var additions:[Addition] = []
        for addition in localDishItem.options {
            let additionTitle = addition.title
            var selectedItems = [AdditionItem]()
            for item in addition.values {
                if item.isSelected {
                    selectedItems.append(item)
                }
            }
            if !selectedItems.isEmpty {
                let newAddition = Addition(id: addition.id, title: additionTitle, values: selectedItems)
                additions.append(newAddition)
            }
        }
        
        // Publishing new order item for populating the cart (with .onChange modifier)
//        orderItem = OrderItem(title: title, image: item.image, totalPrice: totalPrice, count: self.count, selectedAdditions: additions.isEmpty ? nil : additions)
        orderItem = Food(
            id: item.id,
            title: item.title,
            weight: item.weight,
            text: item.text,
            image: item.image,
            price: self.totalPrice,
            category: item.category,
            options: additions,
            countSelected: count)
    }
}
