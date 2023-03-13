//
//  HomeViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var hasScrolled = false
    @Published var showStatusBar = true
    @Published var showFeaturedCourse = false
    @Published var selectedCategoryIndex = 0
    @Published var selectedMenu = FoodModel()
    @Published var selectedDish = Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0)
    
    var menu = FoodModel()

    func changeMenuBy(_ category: Category) {
        selectedMenu = menu.filter { dish in
            dish.category == category.title
        }
    }
    
}
