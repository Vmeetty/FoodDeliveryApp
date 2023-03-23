//
//  OrderView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/21/23.
//

import SwiftUI

struct OrderView: View {
    
    var submitedOrder: SubmitedOrder
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                ForEach(submitedOrder.items) { item in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(item.title + " - \(item.count)шт")
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.primary)
                            Text(item.additions)
                                .font(.footnote.weight(.regular))
                                .foregroundStyle(.secondary)
                        }
                        Text(item.price + " грн")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                Divider()
                    .padding(.vertical)
            }
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text(submitedOrder.info[0].title)
                    .font(.title3.weight(.semibold))
                Text(submitedOrder.info[0].subtitle)
                    .font(.subheadline.weight(.medium))
                Text(submitedOrder.info[1].title)
                    .font(.title3.weight(.semibold))
                Text(submitedOrder.info[1].subtitle)
                    .font(.subheadline.weight(.medium))
                Text(submitedOrder.info[2].title)
                    .font(.title3.weight(.semibold))
                Text(submitedOrder.info[2].subtitle)
                    .font(.subheadline.weight(.medium))
            }
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(submitedOrder: SubmitedOrder(info: [Info(title: "Delivery", subtitle: "Sikorskogo 4d", icon: "location", infoTab: .location), Info(title: "Delivery", subtitle: "Sikorskogo 4d", icon: "location", infoTab: .location), Info(title: "Delivery", subtitle: "Sikorskogo 4d", icon: "location", infoTab: .location)], items: [SubmitedItem(id: UUID(), title: "MIAMI", additions: "1,2,3", count: "4", price: "679")], calculations: [Calculation(title: "Price", value: "679")]))
    }
}
