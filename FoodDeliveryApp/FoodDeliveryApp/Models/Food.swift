//
//  Food.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import Foundation

typealias FoodModel = [Food]

class Food: Identifiable, Codable {
    var id = UUID()
    var title: String
    var weight: String
    var text: String
    var image: String
    var price: String
    var category: String
    var options: [Option]
    
    init(title: String, weight: String, text: String, image: String, price: String, category: String, options: [Option]) {
        self.title = title
        self.weight = weight
        self.text = text
        self.image = image
        self.price = price
        self.category = category
        self.options = options
    }
}

struct Option: Codable {
    var title: String
    var values: [String]
    
    init(title: String, values: [String]) {
        self.title = title
        self.values = values
    }
    
}
