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
                VStack(alignment: .leading) {
                    Text("Твоє замовлення вже готується")
                        .font(.title.weight(.semibold))
                        .padding(.leading, 20)
                    
                    OrderView(submitedOrder: submitedOrder)
                    
                    Text("Дякуємо, що ти є!")
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .center)
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
}

struct OrderSubmitedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSubmitedView(submitedOrder: SubmitedOrder(info: [Info(title: "Delivery", subtitle: "Sikorskogo 4d", icon: "location", infoTab: .location), Info(title: "Delivery", subtitle: "Sikorskogo 4d", icon: "location", infoTab: .location), Info(title: "Delivery", subtitle: "Sikorskogo 4d", icon: "location", infoTab: .location)], items: [SubmitedItem(id: UUID(), title: "MIAMI", additions: "1,2,3", count: "4", price: "679")], calculations: [Calculation(title: "Price", value: "679")]))
            .environmentObject(Model())
    }
}
