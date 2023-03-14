//
//  OrderItemRow.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct OrderItemRow: View {
    @Binding var item: Food
    
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            Image(item.image)
                .resizable()
                .frame(width: 70, height: 70)
                .mask(Circle())
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
            VStack(alignment: .leading, spacing: 15) {
                HStack(alignment: .center, spacing: 8) {
                    Text(item.title)
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                    deleteButton
                }
                HStack(alignment: .center, spacing: 8) {
                    counter
                    Spacer()
                    Text("\(String(format: "%.2f", item.price)) грн")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(20)
    }
    
    var deleteButton: some View {
        Button {
//            viewModel.isDragble ?
//            withAnimation(.closeCard) {
//                model.showDetail = false
//            }
//            : dismiss()
//            fadeOut()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.secondary)
        }
    }
    
    var counter: some View {
        HStack(spacing: 15) {
            Button {
//                if viewModel.count > 1 {
//                    viewModel.count -= 1
//                    viewModel.calculateWith(foodItem: food)
//                }
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .frame(width: 30, height: 30)
                    .background(.ultraThinMaterial, in: Circle())
//                    .backgroundStyle(cornerRadius: 18)
            }
            Text("\(item.countSelected)")
                .lineLimit(1)
            Button {
//                viewModel.count += 1
//                viewModel.calculateWith(foodItem: food)
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .frame(width: 30, height: 30)
                    .background(.ultraThinMaterial, in: Circle())
//                    .backgroundStyle(cornerRadius: 18)
            }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .opacity(0.05)
        )
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemRow(item: .constant(Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(id: 3, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 4, title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 0)))
    }
}
