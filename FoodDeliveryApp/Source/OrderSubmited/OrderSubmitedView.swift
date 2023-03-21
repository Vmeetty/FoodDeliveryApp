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
                
                CertificateView()
                    .frame(height: 220)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding()
                            .offset(y: -30)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.linearGradient(colors: [.teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(40)
                            .offset(y: -60)
                    )
                    .padding(20)
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
