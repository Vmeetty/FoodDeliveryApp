//
//  CartView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var model: Model
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            Group {
                if model.orderItems.isEmpty {
                    Text("В корзині нічого немає")
                        .font(.title2)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .offset(y: -200)
                } else {
                    ScrollView {
                        infoSection
                        itemsSection
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay {
                NavigationBar(hasScrolled: .constant(true), title: "Корзина")
            }
            .background(
                Image("Blob 1")
                    .offset(x: -180, y: 300)
            )
        }
        .onAppear {
            viewModel.orderItemsRef = model.orderItems
        }
    }
    
    var infoSection: some View {
        VStack {
            ForEach(Array(topics.enumerated()), id: \.offset) { index, topic in
                VStack {
                    if index != 0 { Divider() }
                    OrderInfoItem(topic: topic)
                        .padding(.vertical, 10)
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var itemsSection: some View {
        VStack(alignment: .leading) {
            ForEach(Array(model.orderItems.enumerated()), id: \.offset) { index, orderItem in
                
                if index != 0 { Divider() }
                
                OrderItemRow(orderItem: $model.orderItems[index])
                    .environmentObject(viewModel)
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
    }
    
    func calculateTotalPriceFor(item: Food) -> String {
        var total: Double = 0
        total += item.price

        for addition in item.options {
            for addItem in addition.values {
                if addItem.isSelected {
                    if let addItemPrice = addItem.price {
                        guard let safeAddItemPrice = Double(addItemPrice) else {
                            fatalError("addItem.price ->> value format is not correct")
                        }
                        total += safeAddItemPrice
                    }
                }
            }
        }
        total *= Double(item.countSelected)
        return String(format: "%.2f", total)
    }
    
    private func catchAddItemsTitlesBy(index: Int) -> String {
        var tempStrArray: [String] = []
        for option in model.orderItems[index].options {
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

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Model())
    }
}
