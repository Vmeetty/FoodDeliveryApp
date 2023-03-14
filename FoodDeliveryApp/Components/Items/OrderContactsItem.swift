//
//  OrderContactsItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/14/23.
//

import SwiftUI

struct OrderContactsItem: View {
    var title: String
    @State private var answer = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .fontWeight(.medium)
            TextField("Ваша відповідь", text: $answer)
        }
    }
}

struct OrderContactsItem_Previews: PreviewProvider {
    static var previews: some View {
        OrderContactsItem(title: "Квартира/офіс")
    }
}
