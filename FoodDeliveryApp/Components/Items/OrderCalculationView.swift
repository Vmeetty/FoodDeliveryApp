//
//  OrderCalculationView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/15/23.
//

import SwiftUI

struct OrderCalculationView: View {
    @Binding var calculation: Calculation
    @Binding var rate: Int
    @State var count: Int = 0
    
    var body: some View {
        HStack {
            if calculation.title == "Чайові (%)" {
                HStack {
                    Text(calculation.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    CounterView(count: $rate) {
                        if count > 0 {
                            count -= 1
                            rate = count
                        }
                    } plusAction: {
                        if count < 15 {
                            count += 1
                            rate = count
                        }
                    }
                    .padding(2)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .opacity(0.05)
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text("\(calculation.value) грн")
                    .tint(.secondary)
            } else {
                Text(calculation.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(calculation.value) грн")
                    .tint(.secondary)
            }
        }
    }
}

struct OrderCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCalculationView(calculation: .constant(Calculation(title: "Замовлення", value: "800")), rate: .constant(0))
    }
}
