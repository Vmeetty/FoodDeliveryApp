//
//  CartViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/12/23.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var count: Int = 1
    @Published var totalPrice: Double = 0.0
    @Published var orderItemsRef: [Food] = []
    
    func calculateWith() {
//        var total: Double = 0
//        total += localDishItem.price
//
//        for addition in localDishItem.options {
//            for addItem in addition.values {
//                if addItem.isSelected {
//                    if let addItemPrice = addItem.price {
//                        guard let safeAddItemPrice = Double(addItemPrice) else {
//                            fatalError("addItem.price ->> value format is not correct")
//                        }
//                        total += safeAddItemPrice
//                    }
//                }
//            }
//        }
//        total *= Double(count)
//        totalPrice = total
    }
}
