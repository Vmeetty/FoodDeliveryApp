//
//  OrderSubmitedView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/21/23.
//

import SwiftUI

struct OrderSubmitedView: View {
    
    @EnvironmentObject private var model: Model
    @Environment(\.dismiss) var dismiss
    var submitedOrder: SubmitedOrder
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Ваше замовлення вже готується")
                                .font(.title3.weight(.semibold))
                            Divider()
                                .padding(.vertical)
                            ForEach(submitedOrder.items) { item in
                                HStack {
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
                    
                    Text("Дякуємо за замовлення!")
                        .foregroundColor(.primary)
                }
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 90)
            })
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
        .onAppear {
            model.orderItems.removeAll()
        }
    }
    
//    private func parseSubmitedOrder() {
//        let id = submitedOrder.id
//        for info in submitedOrder.info {
//            let
//        }
//    }
}

struct OrderSubmitedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSubmitedView(submitedOrder: SubmitedOrder(info: [Info(title: "Delivery", subtitle: "Sikorskogo 4d", icon: "location", infoTab: .location)], items: [SubmitedItem(id: UUID(), title: "MIAMI", additions: "1,2,3", count: "4", price: "679")], calculations: [Calculation(title: "Price", value: "679")]))
            .environmentObject(Model())
    }
}
