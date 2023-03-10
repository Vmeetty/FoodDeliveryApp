//
//  OrderItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/8/23.
//

import Foundation

class OrderItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var totalPrice: String
    var selectedAdditions: [Addition]
    
    init(title: String, totalPrice: String, selectedAdditions: [Addition]) {
        self.title = title
        self.totalPrice = totalPrice
        self.selectedAdditions = selectedAdditions
    }
}
