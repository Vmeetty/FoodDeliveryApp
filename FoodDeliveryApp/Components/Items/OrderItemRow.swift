//
//  OrderItemRow.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct OrderItemRow: View {
    var item: OrderItem
    
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
                    Text("\(item.totalPrice) грн")
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
        OrderItemRow(item: OrderItem(title: "Kapreze", image: "kapreze", totalPrice: "250", count: 1))
    }
}
