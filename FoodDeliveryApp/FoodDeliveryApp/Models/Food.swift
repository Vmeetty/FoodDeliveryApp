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
}
