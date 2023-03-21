//
//  OrderView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/21/23.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject private var model: Model
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Ваше замовлення вже готується")
                    .font(.title3.weight(.semibold))
                Divider()
                    .padding(.vertical)
                ForEach(model.orderItems) { orderItem in
                    Text(orderItem.title)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.primary)
                }
            }
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text("Час доставки")
                    .font(.title3.weight(.semibold))
                Text("Березень 29, 15:00 - 16:00")
                    .font(.subheadline.weight(.medium))
                Text("Адреса доставки")
                    .font(.title3.weight(.semibold))
                Text(model.locationTimePayment[0].subtitle)
                    .font(.subheadline.weight(.medium))
            }
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Model())
    }
}
