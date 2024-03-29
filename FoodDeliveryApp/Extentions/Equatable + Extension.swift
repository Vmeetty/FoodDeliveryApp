//
//  Equatable + Extension.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/10/23.
//

import Foundation

extension Food: Equatable {
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.weight == rhs.weight &&
        lhs.text == rhs.text &&
        lhs.image == rhs.image &&
        lhs.price == rhs.price &&
        lhs.category == rhs.category &&
        lhs.options == rhs.options &&
        lhs.countSelected == rhs.countSelected
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

extension Contacts: Equatable {
    static func == (lhs: Contacts, rhs: Contacts) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.answer == rhs.answer
    }
}

extension Calculation: Equatable {
    static func == (lhs: Calculation, rhs: Calculation) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.value == rhs.value
    }
}

extension SubmitedOrder: Equatable {
    static func == (lhs: SubmitedOrder, rhs: SubmitedOrder) -> Bool {
        return lhs.id == rhs.id 
    }
}
