//
//  CartViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/12/23.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var calculations: [Calculation] = []
    @Published var rateValue = 0
    @Published var modelIsChanged = false
    @Published var modelReference: Model?
    
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
        
        let delivery = K.Prices.DELIVERY
        
        let rate = Double(rateValue) / 100
        let fee: Double = orderAmount * rate
        
        let totalAmount = orderAmount + fee + delivery
        
        calculations = [
            Calculation(title: "Замовлення", value: "\(String(format: "%.2f", orderAmount))"),
            Calculation(title: "Доставка", value: "\(String(format: "%.2f", delivery))"),
            Calculation(title: "Чайові (%)", value: "\(String(format: "%.2f", fee))"),
            Calculation(title: "До сплати", value: "\(String(format: "%.2f", totalAmount))")
        ]
    }
    
    func createOrder() {
        if let modelReference = modelReference {
            let orderItems = modelReference.orderItems
            let info = modelReference.locationTimePayment
            let contacts = modelReference.contacts
            let calculations = modelReference.calculations
            print(modelReference)
        }
    }
}
