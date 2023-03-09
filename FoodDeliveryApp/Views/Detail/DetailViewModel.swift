//
//  DetailViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/8/23.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    @Published var orderItem: OrderItem = OrderItem(title: "", price: "", selectedAdditions: [])
    @Published var totalPrice: Double = 0
    
    func calculateTotalPrice() {
        var total: Double = 0
        
        guard let price = Double(orderItem.price) else {
            fatalError("orderItem.price ->> doesn't exist or the value format is not correct")
        }
        total += price
        
        for addition in orderItem.selectedAdditions {
            if !addition.values.isEmpty {
                for value in addition.values {
                    let addItemPrice = value.price ?? "0"
                    guard let additionItemPrice = Double(addItemPrice) else {
                        fatalError("orderItem.price ->> doesn't exist or the value format is not correct")
                    }
                    total += additionItemPrice
                }
            }
        }
        totalPrice = total
    }
}
