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
        contacts = [Contacts(title: "Квартира/офіс", answer: ""), Contacts(title: "Під‘їзд", answer: ""), Contacts(title: "Поверх", answer: ""), Contacts(title: "Домофон", answer: ""), Contacts(title: "Ваше ім‘я", answer: ""), Contacts(title: "Телефон для зв‘язку", answer: ""), Contacts(title: "Кількість приборів", answer: "1"), Contacts(title: "Коментар", answer: "")]
    }
}
