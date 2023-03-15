//
//  CartViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/12/23.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var contacts: [Contacts] = []
    @Published var calculations: [Calculation] = []
    @Published var rateValue = 0
    
    func createContacts() {
        contacts = [Contacts(title: "Квартира/офіс", answer: ""), Contacts(title: "Під‘їзд", answer: ""), Contacts(title: "Поверх", answer: ""), Contacts(title: "Домофон", answer: ""), Contacts(title: "Ваше ім‘я", answer: ""), Contacts(title: "Телефон для зв‘язку", answer: ""), Contacts(title: "Кількість приборів", answer: "1"), Contacts(title: "Коментар", answer: "")]
        
    }
    
    func calculate(orderItems: [Food]) {
        var orderAmount: Double = 0.00
        var selectedAdditionItems: [AdditionItem] = []
        
        for orderItem in orderItems {
            var itemAmount = orderItem.price
            
            for addition in orderItem.options {
                for additionItem in addition.values {
                    if additionItem.isSelected { selectedAdditionItems.append(additionItem) }
                }
            }
            for selectedItem in selectedAdditionItems {
                if let selectedItemPrice = selectedItem.price {
                    guard let safeAddItemPrice = Double(selectedItemPrice) else {
                        fatalError("addItem.price ->> value format is not correct")
                    }
                    itemAmount += safeAddItemPrice
                }
            }
            itemAmount *= Double(orderItem.countSelected)
            orderAmount += itemAmount
            
        }
        
        let rate = Double(rateValue) / 100
        
        let delivery = K.Prices.DELIVERY
        let fee: Double = orderAmount * rate
        let totalAmount = orderAmount + fee + delivery
        
        calculations = [
            Calculation(title: "Замовлення", value: "\(String(format: "%.2f", orderAmount))"),
            Calculation(title: "Доставка", value: "\(String(format: "%.2f", delivery))"),
            Calculation(title: "Чайові", value: "\(String(format: "%.2f", fee))"),
            Calculation(title: "До сплати", value: "\(String(format: "%.2f", totalAmount))")
        ]
    }
    
}

// String(format: "%.2f", total)
