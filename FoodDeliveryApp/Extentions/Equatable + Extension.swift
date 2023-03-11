//
//  Equatable + Extension.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/10/23.
//

import Foundation

extension OrderItem: Equatable {
    static func == (lhs: OrderItem, rhs: OrderItem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.image == rhs.image &&
        lhs.totalPrice == rhs.totalPrice &&
        lhs.count == rhs.count &&
        lhs.selectedAdditions == rhs.selectedAdditions
    }
}

extension Addition: Equatable {
    static func == (lhs: Addition, rhs: Addition) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.values == rhs.values
    }
}

extension AdditionItem: Equatable {
    static func == (lhs: AdditionItem, rhs: AdditionItem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.price == rhs.price &&
        lhs.isSelected == rhs.isSelected
    }
}