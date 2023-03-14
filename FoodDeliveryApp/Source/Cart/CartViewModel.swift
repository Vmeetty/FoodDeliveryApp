//
//  CartViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/12/23.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var contacts: [Contacts] = []
    
    func createContacts() {
        contacts = [Contacts(title: "Квартира/офіс"), Contacts(title: "Під‘їзд"), Contacts(title: "Поверх"), Contacts(title: "Домофон"), Contacts(title: "Ваше ім‘я"), Contacts(title: "Телефон для зв‘язку"), Contacts(title: "Кількість приборів"), Contacts(title: "Коментар")]
    }
}
