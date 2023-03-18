//
//  Constants.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/15/23.
//

import Foundation

struct K {
    struct Prices {
        static let DELIVERY: Double = 35.0
    }
    
    struct PopUps {
        static let PAYMENT = [PaymentPopUpData(title: "Готівкою при одержані", icon: "banknote.fill"), PaymentPopUpData(title: "Карткою при одержані", icon: "creditcard.fill")]
    }
}

struct PaymentPopUpData: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}
