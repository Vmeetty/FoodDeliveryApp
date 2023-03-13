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
                    closeButton
                }
                HStack(alignment: .center, spacing: 8) {
                    CounterView()
                    Spacer()
                    Text("\(item.price) грн")
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(20)
    }
    
    var closeButton: some View {
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
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemRow(item: .constant(Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 0)))
    }
}
