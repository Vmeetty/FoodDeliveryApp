//
//  AdditionRow.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/7/23.
//

import SwiftUI

struct AdditionRow: View {
    var addition: Addition
    @State var isExpanded = false
    @State var appear = false
    @State var selectIcon = "square"
    
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
                        Text("Додано - \(0)")
                            .font(.caption.weight(.medium))
                            .tint(.secondary)
                    }
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.secondary)
                }
            }
            
            if isExpanded {
                Divider()
                ForEach(addition.values) { value in
                    HStack {
                        HStack {
                            Image(systemName: selectIcon)
                                .foregroundColor(.secondary)
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
                        print("\(addition.title): \n\(value.title) - \(value.price ?? "0 грн") selected")
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
        AdditionRow(addition: Addition(title: "Extra", values: [AdditionValue(title: "Так"), AdditionValue(title: "Ні")]))
    }
}
