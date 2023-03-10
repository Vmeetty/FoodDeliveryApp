//
//  OrderItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/8/23.
//

import Foundation

class OrderItem: Identifiable, Codable {
    var id = UUID()
    var image: String
    var title: String
    var totalPrice: String
    var count: Int
    var selectedAdditions: [Addition]?
    
    init(title: String, image: String, totalPrice: String, count: Int, selectedAdditions: [Addition]? = nil) {
        self.title = title
        self.image = image
        self.totalPrice = totalPrice
        self.count = count
        self.selectedAdditions = selectedAdditions
    }
}
