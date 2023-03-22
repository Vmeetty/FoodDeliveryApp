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
    @Published var orderSubmited = false
    @Published var submitedOrder: SubmitedOrder?
    
    func calculate(orderItems: [Food]) {
        var orderAmount: Double = 0.00
        
        for orderItem in orderItems {
            let itemAmount = calculateItemAmount(orderItem: orderItem)
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
    
    func calculateItemAmount(orderItem: Food) -> Double {
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
        
        return itemAmount
    }
    
    func createOrder() {
        if let modelReference = modelReference {
            let info = modelReference.locationTimePayment
            let submitedItems = createNewOrderItem(orderItems: modelReference.orderItems)
            let calculations = modelReference.calculations
            
            let submitedOrder = SubmitedOrder(info: info, items: submitedItems, calculations: calculations)
            self.submitedOrder = submitedOrder
            self.modelReference?.submitedOrders.append(submitedOrder)
            
            withAnimation(.easeInOut) {
                orderSubmited = true
            }
        }
    }
    
    func createNewOrderItem(orderItems: [Food]) -> [SubmitedItem] {
        var submitedItems: [SubmitedItem] = []
        
        for orderItem in orderItems {
            let id = orderItem.id
            let title = orderItem.title
            let options = catchAddItemsTitles(orderItem: orderItem)
            let count = String(orderItem.countSelected)
            let price = String(calculateItemAmount(orderItem: orderItem))
            let submitedItem = SubmitedItem(id: id, title: title, additions: options, count: count, price: price)
            submitedItems.append(submitedItem)
        }
        
        return submitedItems
    }
    
    func catchAddItemsTitles(orderItem: Food) -> String {
        var tempStrArray: [String] = []
        for option in orderItem.options {
            for value in option.values {
                if value.isSelected {
                    tempStrArray.append(value.title)
                }
            }
        }
        
        var tempStr = ""
        for (index, addTitlte) in tempStrArray.enumerated() {
            tempStr += index == 0 ? addTitlte : ", \(addTitlte)"
        }
        return tempStr
    }
    
}

struct SubmitedOrder: Identifiable {
    var id = UUID().uuidString
    var info: [Info]
    var items: [SubmitedItem]
    var calculations: [Calculation]
}

struct SubmitedItem: Identifiable {
    var id: UUID
    var title: String
    var additions: String
    var count: String
    var price: String
}
