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
            if calculation.title == "Чайові" {
                HStack {
                    Text(calculation.title)
                        .fontWeight(.bold)
                    CounterView(count: count) {
                        if count > 0 {
                            rate -= 1
                            count -= 1
                        }
                    } plusAction: {
                        rate += 1
                        count += 1
                    }
                }
                Text("\(calculation.value) грн")
                    .tint(.secondary)
            } else {
                Text(calculation.title)
                    .fontWeight(.bold)
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
