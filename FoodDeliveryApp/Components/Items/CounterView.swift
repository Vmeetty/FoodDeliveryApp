//
//  CounterView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/11/23.
//

import SwiftUI

struct CounterView: View {
    var body: some View {
        HStack(spacing: 15) {
            Button {
//                if viewModel.count > 1 {
//                    viewModel.count -= 1
//                    viewModel.calculateWith(foodItem: food)
//                }
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .frame(width: 30, height: 30)
                    .background(.ultraThinMaterial, in: Circle())
//                    .backgroundStyle(cornerRadius: 18)
            }
            Text("\(1)")
                .lineLimit(1)
            Button {
//                viewModel.count += 1
//                viewModel.calculateWith(foodItem: food)
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(8)
                    .frame(width: 30, height: 30)
                    .background(.ultraThinMaterial, in: Circle())
//                    .backgroundStyle(cornerRadius: 18)
            }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .opacity(0.05)
        )
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
