//
//  OrderContactsItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/14/23.
//

import SwiftUI

struct OrderContactsItem: View {
    var title: String
    @State private var answer: String = ""
    @State private var count: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            switch title {
            case "Поверх":
                Text(title)
                    .fontWeight(.medium)
                TextField("Ваша відповідь", text: $answer)
                    .textContentType(.oneTimeCode)
                    .keyboardType(.numberPad)
            case "Телефон для зв‘язку":
                Text(title)
                    .fontWeight(.medium)
                TextField("Ваша відповідь", text: $answer)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
            case "Кількість приборів":
                HStack(spacing: 0) {
                    Text(title)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    CounterView(count: $count) {
                        if count > 0 { count -= 1 }
                    } plusAction: {
                        count += 1
                    }
                    .padding(2)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .opacity(0.05)
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            default:
                Text(title)
                TextField("Ваша відповідь", text: $answer)
            }
            
        }
    }
}

struct OrderContactsItem_Previews: PreviewProvider {
    static var previews: some View {
        OrderContactsItem(title: "Квартира/офіс")
    }
}
