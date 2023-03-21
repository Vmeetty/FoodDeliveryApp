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
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            ScrollView {
                VStack {
                    OrderView()
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
    }
}

struct OrderSubmitedView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSubmitedView()
    }
}
