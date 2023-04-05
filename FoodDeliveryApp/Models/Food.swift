//
//  Food.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import Foundation

typealias FoodModel = [Food]

class Food: Identifiable, Codable {
    var id: UUID
    var title: String
    var weight: String
    var text: String
    var image: String
    var price: Double
    var category: String
    var options: [Addition]
    var countSelected: Int
    
    init(id: UUID = UUID(), title: String, weight: String, text: String, image: String, price: Double, category: String, options: [Addition], countSelected: Int) {
        self.id = id
        self.title = title
        self.weight = weight
        self.text = text
        self.image = image
        self.price = price
        self.category = category
        self.options = options
        self.countSelected = countSelected
    }
}

struct Addition: Identifiable, Codable {
    var id: Int
    var title: String
    var values: [AdditionItem]
}

struct AdditionItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var price: String?
    var isSelected: Bool = false
}
