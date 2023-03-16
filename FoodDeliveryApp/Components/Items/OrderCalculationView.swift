//
//  OrderCalculationView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/15/23.
//

import SwiftUI

struct OrderCalculationView: View {
    @Binding var calculations: [Calculation]
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
                    CounterView(count: $count) {
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
        .onAppear {
            getRate()
        }
    }
    
    func getRate() {
        if !calculations.isEmpty {
            guard let fee = Double(calculation.value) else {
                fatalError("calculation.value ->> value format is not correct")
            }
            guard let amount = Double(calculations[0].value) else {
                fatalError("calculations[0].value ->> value format is not correct")
            }
            let rate = String(format: "%.2f", fee / amount * 100)
            
            if let intRate = Int(rate) {
                count = intRate
            }
        }
    }
}

struct OrderCalculationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCalculationView(calculations: .constant([Calculation(title: "Замовлення", value: "800")]), calculation: .constant(Calculation(title: "Замовлення", value: "800")), rate: .constant(0))
    }
}
