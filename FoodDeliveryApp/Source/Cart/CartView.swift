//
//  CartView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var model: Model
    @StateObject var viewModel = CartViewModel()
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                infoSection
                itemsSection
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay {
                NavigationBar(hasScrolled: .constant(true), title: "Корзина")
            }
            .background(
                Image("Blob 1")
                    .offset(x: -180, y: 300)
            )
        }
    }
    
    var infoSection: some View {
        VStack {
            ForEach(Array(topics.enumerated()), id: \.offset) { index, topic in
                VStack {
                    if index != 0 { Divider() }
                    OrderInfoItem(topic: topic)
                        .padding(.vertical, 10)
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
    
    var itemsSection: some View {
        VStack(alignment: .leading) {
            ForEach(Array(model.orderItems.enumerated()), id: \.offset) { index, _ in
                if index != 0 { Divider() }
                OrderItemRow(item: $model.orderItems[index])
                    .environmentObject(viewModel)
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
        .onReceive(viewModel.$foodModelChanged) { newValue in
            if newValue { viewModel.calculateWith() }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Model())
    }
}
