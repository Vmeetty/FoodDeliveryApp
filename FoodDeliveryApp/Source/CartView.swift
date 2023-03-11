//
//  CartView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                sectionsSection
            }
            .safeAreaInset(edge: .top) {
                Color.clear.frame(height: 70)
            }
            .overlay {
                NavigationBar(hasScrolled: .constant(true), title: "Notifications")
            }
            .background(
                Image("Blob 1")
                    .offset(x: -180, y: 300)
            )
        }
    }
    
    var sectionsSection: some View {
        VStack(alignment: .leading) {
            ForEach(Array(model.orderItems.enumerated()), id: \.offset) { index, item in
                if index != 0 { Divider() }
                OrderItemRow(item: item)
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
