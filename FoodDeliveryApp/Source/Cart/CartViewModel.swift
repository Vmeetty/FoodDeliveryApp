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
    @Published var modelIsChanged = false
    @Published var modelReference: Model?
    
    func createContacts() {
        contacts = [Contacts(title: "Квартира/офіс", answer: ""), Contacts(title: "Під‘їзд", answer: ""), Contacts(title: "Поверх", answer: ""), Contacts(title: "Домофон", answer: ""), Contacts(title: "Ваше ім‘я", answer: ""), Contacts(title: "Телефон для зв‘язку", answer: ""), Contacts(title: "Кількість приборів", answer: "1"), Contacts(title: "Коментар", answer: "")]
        
    }
    
//    func checkRate() {
//        if let modelReference = modelReference {
//            if !modelReference.calculations.isEmpty {
//
//            }
//        }
//    }
    
    func calculate(orderItems: [Food]) {
        var orderAmount: Double = 0.00
        
        for orderItem in orderItems {
            var itemAmount = orderItem.price
            var selectedAdditionItems: [AdditionItem] = []
            
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
        
        if rateValue == 0 {
            rateValue = getRate(of: orderAmount)
        }
        
        let rate = Double(rateValue) / 100
        
        let delivery = K.Prices.DELIVERY
        let fee: Double = orderAmount * rate
        let totalAmount = orderAmount + fee + delivery
        
        calculations = [
            Calculation(title: "Замовлення", value: "\(String(format: "%.2f", orderAmount))"),
            Calculation(title: "Доставка", value: "\(String(format: "%.2f", delivery))"),
            Calculation(title: "Чайові (%)", value: "\(String(format: "%.2f", fee))"),
            Calculation(title: "До сплати", value: "\(String(format: "%.2f", totalAmount))")
        ]
    }
    
    func getRate(of orderAmount: Double) -> Int {
        if let modelReference = modelReference {
            if !modelReference.calculations.isEmpty {
                guard let fee = Double(modelReference.calculations[2].value) else {
                    fatalError("calculation.value ->> value format is not correct")
                }
                
                let rate = fee / orderAmount * 100
                
                return Int(rate)
            }
            return 0
        }
        return 0
    }
}
