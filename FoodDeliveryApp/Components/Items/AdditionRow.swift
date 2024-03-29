//
//  AdditionRow.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/7/23.
//

import SwiftUI

struct AdditionRow: View {
    @Binding var addition: Addition
    @State var isExpanded = false
    @State var appear = false
    @State var additionsSelected = [String]()
    @State var checkedAdditions = "Нічого не додано"
    
    @EnvironmentObject var detailVM: DetailViewModel
    
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
                            Text(checkedAdditions)
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
                        Text("\(value.price ?? "0") грн")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .onTapGesture {
                        addition.values[index].isSelected = !value.isSelected ? true : false
                        catchAddItemsTitles()
                        detailVM.foodHasBeenChanged()
                    }
                    .opacity(appear ? 1 : 0)
                }
            }
        }
        .padding(20)
        .padding(.horizontal, 20)
    }
    
    private func catchAddItemsTitles() {
        var tempStrArray: [String] = []
        for addtionItem in addition.values {
            if addtionItem.isSelected {
                tempStrArray.append(addtionItem.title)
            }
        }
        var tempStr = ""
        for (index, addTitlte) in tempStrArray.enumerated() {
            tempStr += index == 0 ? addTitlte : ", \(addTitlte)"
        }
        checkedAdditions = tempStrArray.isEmpty ? "Нічого не додано" : tempStr
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
        AdditionRow(addition: .constant(Addition(id: 1, title: "Extra", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])))
    }
}
