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
            
            ScrollView {
                if model.orderItems.isEmpty {
                    Text("В корзині нічого немає")
                        .font(.title2)
                        .foregroundColor(.primary)
                        .frame(maxHeight: .infinity)
                } else {
                    infoSection
                    itemsSection
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
                
                HStack(alignment: .top, spacing: 14) {
                    Image(model.orderItems[index].image)
                        .resizable()
                        .frame(width: 70, height: 70)
                        .mask(Circle())
                        .background(Color(UIColor.systemBackground).opacity(0.3))
                        .mask(Circle())
                    VStack(alignment: .leading, spacing: 15) {
                        HStack(alignment: .top, spacing: 8) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(model.orderItems[index].title)
                                    .font(.body)
                                    .fontWeight(.semibold)
                                if catchAddItemsTitlesBy(index: index) != "" {
                                    Text(catchAddItemsTitlesBy(index: index))
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                            
                            Button {
                                model.orderItems.remove(at: index)
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.secondary)
                            }
                        }
                        HStack(alignment: .center, spacing: 8) {
                            
                            HStack(spacing: 5) {
                                Button {
                                    if model.orderItems[index].countSelected > 1 {
                                        model.orderItems[index].countSelected -= 1
                                    }
                                } label: {
                                    Image(systemName: "minus")
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(.secondary)
                                        .padding(8)
                                        .frame(width: 30, height: 30)
                                        .background(.ultraThinMaterial, in: Circle())
                                }
                                
                                Text("\(model.orderItems[index].countSelected)")
                                    .lineLimit(1)
                                    .frame(width: 30)
                                
                                Button {
                                    model.orderItems[index].countSelected += 1
                                } label: {
                                    Image(systemName: "plus")
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(.secondary)
                                        .padding(8)
                                        .frame(width: 30, height: 30)
                                        .background(.ultraThinMaterial, in: Circle())
                                }
                            }
                            .padding(2)
                            .background(
                                RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .opacity(0.05)
                            )
                            
                            Text("\(calculateTotalPriceBy(index: index)) грн")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(20)
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
    }
    
    func calculateTotalPriceBy(index: Int) -> String {
        var total: Double = 0
        total += model.orderItems[index].price

        for addition in model.orderItems[index].options {
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
        total *= Double(model.orderItems[index].countSelected)
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
