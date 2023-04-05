//
//  OrdersHistoryView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct OrdersHistoryView: View {
    
    @EnvironmentObject private var model: Model
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                if model.ordersHistory.isEmpty {
                    Text("Ще не було замовлень")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .offset(y: 50)
                } else {
                    VStack {
                        ForEach(model.ordersHistory) { order in
                            OrderView(submitedOrder: order)
                        }
                    }
                }
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay {
                NavigationBar(hasScrolled: .constant(true), title: "Історія замовлень")
            }
            .background(Image("Blob 1").offset(x: -70, y: -300))
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersHistoryView()
            .environmentObject(Model())
    }
}
