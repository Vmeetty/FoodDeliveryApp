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
        HStack(alignment: .top, spacing: 16) {
            Image(item.image)
                .resizable()
                .frame(width: 36, height: 36)
                .mask(Circle())
                .padding(12)
                .background(Color(UIColor.systemBackground).opacity(0.3))
                .mask(Circle())
            VStack(alignment: .leading, spacing: 8) {
                Text(item.title)
                    .fontWeight(.semibold)
                if let additions = item.selectedAdditions {
                    ForEach(additions) { addition in
                        /*@START_MENU_TOKEN@*/Text(addition.title)/*@END_MENU_TOKEN@*/
                            .font(.caption.weight(.medium))
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding(20)
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemRow(item: OrderItem(title: "Kapreze", image: "kapreze", totalPrice: "250", count: 1))
    }
}
