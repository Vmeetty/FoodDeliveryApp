//
//  Food.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct Food: Identifiable {
    let id = UUID()
    var title: String
    var weight: String
    var text: String
    var image: String
    var price: String
    var category: String
    var options: [Option]
}

struct Option {
    var title: String
    var values: [String]
}
