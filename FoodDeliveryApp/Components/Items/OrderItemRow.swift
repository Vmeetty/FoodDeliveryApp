//
//  OrderItemRow.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct OrderItemRow: View {
    @Binding var orderItem: Food
    @EnvironmentObject var cartViewModel: CartViewModel
    @State var count: Int
    let deleteAction: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            Image(orderItem.image)
                .resizable()
                .frame(width: 70, height: 70)
                .mask(Circle())
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
            VStack(alignment: .leading, spacing: 15) {
                HStack(alignment: .top, spacing: 8) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(orderItem.title)
                            .font(.body)
                            .fontWeight(.semibold)
                        if cartViewModel.catchAdditionItemsTitles(orderItem: orderItem) != "" {
                            Text(cartViewModel.catchAdditionItemsTitles(orderItem: orderItem))
                                .font(.footnote)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                    
                    deleteButton
                }
                HStack(alignment: .center, spacing: 8) {
                    
                    counter
                    
                    Text("\(calculateTotalPriceBy()) грн")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    var deleteButton: some View {
        Button {
            deleteAction()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.secondary)
        }
    }
    
    var counter: some View {
        HStack(spacing: 5) {
            Button {
                if count > 1 {
                    count -= 1
                    orderItem.countSelected -= 1
                    cartViewModel.modelIsChanged.toggle()
                }
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .frame(width: 30, height: 30)
                    .background(.ultraThinMaterial, in: Circle())
            }
            
            Text("\(count)")
                .lineLimit(1)
                .frame(width: 30)
            
            Button {
                count += 1
                orderItem.countSelected += 1
                cartViewModel.modelIsChanged.toggle()
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
    }
    
    func calculateTotalPriceBy() -> String {
        var total: Double = 0
        total += orderItem.price
        
        var selectedItems: [AdditionItem] = []

        for addition in orderItem.options {
            selectedItems = addition.values.filter({ $0.isSelected })
        }
        
        for item in selectedItems {
            if item.isSelected {
                if let addItemPrice = item.price {
                    guard let safeAddItemPrice = Double(addItemPrice) else {
                        fatalError("addItem.price ->> value format is not correct")
                    }
                    total += safeAddItemPrice
                }
            }
        }
        
        total *= Double(orderItem.countSelected)
        return String(format: "%.2f", total)
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemRow(orderItem: .constant(Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(id: 3, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 4, title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 1)), count: 1, deleteAction: {
            print("")
        })
    }
}
