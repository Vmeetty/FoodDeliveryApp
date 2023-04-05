//
//  SubmitedOrder.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/29/23.
//

import Foundation

struct SubmitedOrder: Identifiable {
    var id = UUID().uuidString
    var info: [Info]
    var items: [SubmitedItem]
    var contacts: [Contacts]
    var calculations: [Calculation]
}

struct SubmitedItem: Identifiable {
    var id: UUID
    var title: String
    var additions: String
    var count: String
    var price: String
}
