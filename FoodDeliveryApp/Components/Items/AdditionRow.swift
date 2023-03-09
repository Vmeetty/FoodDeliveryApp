//
//  AdditionRow.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/7/23.
//

import SwiftUI

struct AdditionRow: View {
    @State var addition: Addition
    @State var isExpanded = false
    @State var appear = false
    @State var additionsSelected = [String]()
    
    @EnvironmentObject var detailViewModel: DetailViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Button {
                !isExpanded ? fadeIn() : fadeOut()
            } label: {
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(addition.title)
                            .fontWeight(.semibold)
                            .tint(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        if additionsSelected.isEmpty {
                            Text("Натисніть, щоб додати")
                                .font(.caption.weight(.medium))
                                .tint(.secondary)
                        }
                    }
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.primary)
                }
            }
            
            if isExpanded {
                Divider()
                ForEach(Array(addition.values.enumerated()), id: \.offset) { index, value in
                    HStack {
                        HStack {
                            Image(systemName: !value.isSelected ? "square" : "square.fill")
                                .foregroundStyle(.linearGradient(colors: [.pink, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            Text(value.title)
                                .fontWeight(.regular)
                                .foregroundStyle(.primary)
                        }
                        Spacer()
                        Text(value.price ?? "0 грн")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .onTapGesture {
                        if !value.isSelected {
                            addition.values[index].isSelected = true
                            let newAdditionItem = AdditionItem(title: value.title, price: value.price, isSelected: true)
                            var addExists = false
                            for (ind, selectedAddition) in detailViewModel.orderItem.selectedAdditions.enumerated() {
                                if selectedAddition.title == value.title {
                                    addExists = true
                                    detailViewModel.orderItem.selectedAdditions[ind].values.append(newAdditionItem)
                                    return
                                }
                            }
                            if !addExists {
                                let newAddition = Addition(title: value.title, values: [newAdditionItem])
                                detailViewModel.orderItem.selectedAdditions.append(newAddition)
                            }
                            detailViewModel.calculateTotalPrice()
                        } else {
                            addition.values[index].isSelected = false
                            for (ind, selectedAddition) in detailViewModel.orderItem.selectedAdditions.enumerated() {
                                if selectedAddition.title == addition.title {
                                    if selectedAddition.values.count < 2 {
                                        detailViewModel.orderItem.selectedAdditions.remove(at: ind)
                                        detailViewModel.calculateTotalPrice()
                                    } else {
                                        for (itemInd, item) in detailViewModel.orderItem.selectedAdditions[ind].values.enumerated() {
                                            if item.id == value.id {
                                                detailViewModel.orderItem.selectedAdditions[ind].values.remove(at: itemInd)
                                                detailViewModel.calculateTotalPrice()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .opacity(appear ? 1 : 0)
                }
            }
        }
        .padding(20)
        .padding(.horizontal, 20)
    }
    
    private func fadeIn() {
        withAnimation(.easeOut) {
            isExpanded = true
        }
        withAnimation(.easeOut.delay(0.3)) {
            appear = true
        }
    }
    
    private func fadeOut() {
        withAnimation(.easeOut) {
            appear = false
        }
        withAnimation(.easeOut.delay(0.2)) {
            isExpanded = false
        }
    }
}

struct AdditionRow_Previews: PreviewProvider {

    static var previews: some View {
        AdditionRow(addition: Addition(title: "Extra", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]))
    }
}
