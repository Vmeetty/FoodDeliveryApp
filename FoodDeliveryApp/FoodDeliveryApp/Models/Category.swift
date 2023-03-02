//
//  Category.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    var title: String
    var icon: String
}

var categories = [
    Category(title: "Burger", icon: "heart.circle.fill"),
    Category(title: "Pizza", icon: "eyedropper"),
    Category(title: "Salate", icon: "laptopcomputer"),
    Category(title: "Soup", icon: "iphone"),
    Category(title: "Dessert", icon: "eyedropper"),
    Category(title: "Web development", icon: "laptopcomputer"),
    Category(title: "Pasta", icon: "iphone"),
    Category(title: "Bar", icon: "eyedropper")
]
