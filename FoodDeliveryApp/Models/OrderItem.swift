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
    var price: String
    var selectedAdditions: [Addition]
    
    init(title: String, price: String, selectedAdditions: [Addition]) {
        self.title = title
        self.price = price
        self.selectedAdditions = selectedAdditions
    }
}
