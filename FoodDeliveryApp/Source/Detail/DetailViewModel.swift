//
//  DetailViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/8/23.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var foodModelChanged = false
    @Published var totalPrice: Double = 0.0
    @Published var isDragble = true
    @Published var viewState: CGSize = .zero
    @Published var appear = [false, false, false, false]
    @Published var count: Int = 1
    @Published var localDishItem = Food(title: "", weight: "", text: "", image: "MIAMI", price: 0.0, category: "", options: [], countSelected: 0)
    @Published var modelReference: Model?
    
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
        totalPrice = total
    }
    
    func foodHasBeenChanged() {
        foodModelChanged = true
    }
    
    func startAddingItemToCart(item: Food) {
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
        
        let orderItem = Food(
            id: item.id,
            title: item.title,
            weight: item.weight,
            text: item.text,
            image: item.image,
            price: item.price,
            category: item.category,
            options: additions,
            countSelected: count)
        
        addToCart(orderItem: orderItem) // adding to Cart
    }
    
    func addToCart(orderItem: Food) {
        if modelReference != nil {
            if modelReference!.orderItems.isEmpty {
                modelReference!.orderItems.append(orderItem)
            } else {
                var matchedIndex: Int?
                for (index, item) in modelReference!.orderItems.enumerated() {
                    if item.id == orderItem.id {
                        if item.options == orderItem.options {
                            matchedIndex = index
                        }
                    }
                }
                if let matchedIndex = matchedIndex {
                    modelReference!.orderItems[matchedIndex].price += orderItem.price
                    modelReference!.orderItems[matchedIndex].countSelected += orderItem.countSelected
                } else {
                    modelReference!.orderItems.append(orderItem)
                }
            }
        }
    }
}
