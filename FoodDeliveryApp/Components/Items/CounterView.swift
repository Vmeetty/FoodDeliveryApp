//
//  CounterView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/11/23.
//

import SwiftUI

struct CounterView: View {
    @State var count: Int
    let minusAction: () -> Void
    let plusAction: () -> Void
    
    var body: some View {
        HStack(spacing: 5) {
            Button {
                minusAction()
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .frame(width: 30, height: 30)
                    .background(.ultraThinMaterial, in: Circle())
            }
            
            Text("\(count)")
                .lineLimit(1)
                .frame(width: 30)
            
            Button {
                plusAction()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .frame(width: 30, height: 30)
                    .background(.ultraThinMaterial, in: Circle())
            }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView(count: 1, minusAction: {
            
        }, plusAction: {
            
        })
    }
}
