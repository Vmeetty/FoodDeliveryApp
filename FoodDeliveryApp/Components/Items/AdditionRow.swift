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
    
    var body: some View {
        VStack(spacing: 12) {
            Button {
                !isExpanded ? fadeIn() : fadeOut()
            } label: {
                HStack {
                    Text(addition.title)
                        .font(.title3)
                        .fontWeight(.regular)
                        .tint(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text("Додано - \(0)")
                        .font(.caption.weight(.medium))
                        .tint(.secondary)
                }
            }
            
            if isExpanded {
                ForEach(addition.values) { value in
                    HStack {
                        HStack {
                            Image(systemName: "square")
                                .font(.title2)
                            Text(value.title)
                                .fontWeight(.medium)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(value.price ?? "0 грн")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .opacity(appear ? 1 : 0)
                }
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .strokeStyle(cornerRadius: 18)
        .padding(20)
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
