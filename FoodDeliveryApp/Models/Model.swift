//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/6/23.
//

import Foundation

class Model: ObservableObject {
    // MARK: properties
    @Published var showDetail = false
    @Published var selectedModalView: ModalEnum = .signIn
    @Published var categories: [Category] = []
    @Published var fullMenu: [Food] = []
    @Published var featuredPromotions: [Food] = []
    
    // MARK: Cart
    @Published var orderItems: [Food] = []
    @Published var calculations: [Calculation] = []
    @Published var rateValue: Int = 0
    @Published var contacts: [Contacts] = []
    
    init() {
        getCategories()
        getMenu()
        getFeaturedPromotions()
        getContacts()
    }
    
    //MARK: methods
    func getCategories() {
        categories = [
            Category(title: "Burger", icon: "heart.circle.fill"),
            Category(title: "Pizza", icon: "eyedropper"),
            Category(title: "Salate", icon: "laptopcomputer"),
            Category(title: "Soup", icon: "iphone"),
            Category(title: "Dessert", icon: "eyedropper"),
            Category(title: "Web development", icon: "laptopcomputer"),
            Category(title: "Pasta", icon: "iphone"),
            Category(title: "Bar", icon: "eyedropper")
        ]
    }
    
    func getMenu() {
        fullMenu = [
            Food(title: "THE BURGER", weight: "Вага 540 г", text: "Лосось, моцарела, рікота, пармезан, червона ікра, рукола. Алергени: злаки, лактоза, риба.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.", image: "THEBURGER", price: 330.00, category: "Burger", options: [Addition(id: 1, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 2, title: "Бекон", values: [AdditionItem(title: "5гр", price: "15"), AdditionItem(title: "10гр", price: "25")])], countSelected: 0),
            Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(id: 3, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 4, title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 0),
            Food(title: "COLORADO", weight: "Вага 430 г", text: "Моцарела, мінітомати, рукола, пармезан. Алергени: злаки, лактоза.", image: "COLORADO", price: 350.00, category: "Burger", options: [Addition(id: 5, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "TENNESSE", weight: "Вага 340 г", text: "Моцарела, горгонзола, пармезан, проволоне. Алергени: злаки, лактоза.", image: "TENNESSE", price: 360.00, category: "Burger", options: [Addition(id: 6, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "NEW ORLEANS", weight: "Вага 410 г", text: "Моцарела, білі гриби, рікота, пармезан. Алергени: злаки, лактоза.", image: "NEW ORLEANS", price: 290.00, category: "Burger", options: [Addition(id: 7, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "SUPREME NACHO", weight: "Вага 420 г", text: "Перетерті томати, моцарела, салямі пікантна пепероні. Алергени: злаки, лактоза.", image: "SUPREME NACHO", price: 360.00, category: "Burger", options: [Addition(id: 8, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "NEW YORK", weight: "Вага 470 г", text: "Перетерті томати, моцарела, прошутто котто, ковбаски, салямі на На ваш вибір - с гострим перцем або ні . Алергени: злаки, лактоза.", image: "NEW YORK", price: 340.00, category: "Burger", options: [Addition(id: 9, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "ARKANSAS", weight: "Вага 500 г", text: "Перетерті томати, артишоки, прошуто кото, оливки каламата, свіжі печериці, моцарела. Алергени: злаки, лактоза.", image: "ARKANSAS", price: 270.00, category: "Burger", options: [Addition(id: 10, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Селмон", weight: "Вага 540 г", text: "Лосось, моцарела, рікота, пармезан, червона ікра, рукола. Алергени: злаки, лактоза, риба.", image: "calmone", price: 385.00, category: "Pizza", options: [Addition(id: 11, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Маргарита", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "margarita", price: 185.00, category: "Pizza", options: [Addition(id: 12, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Капрезе", weight: "Вага 430 г", text: "Моцарела, мінітомати, рукола, пармезан. Алергени: злаки, лактоза.", image: "kapreze", price: 265.00, category: "Pizza", options: [Addition(id: 13, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Кватро Формаджі", weight: "Вага 340 г", text: "Моцарела, горгонзола, пармезан, проволоне. Алергени: злаки, лактоза.", image: "kvattro-formadzhi", price: 275.00, category: "Pizza", options: [Addition(id: 14, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Тоскана", weight: "Вага 410 г", text: "Моцарела, білі гриби, рікота, пармезан. Алергени: злаки, лактоза.", image: "tockana", price: 325.00, category: "Pizza", options: [Addition(id: 15, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Пепероні", weight: "Вага 420 г", text: "Перетерті томати, моцарела, салямі пікантна пепероні. Алергени: злаки, лактоза.", image: "peperoni", price: 280.00, category: "Pizza", options: [Addition(id: 16, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Іль Мачельяно", weight: "Вага 470 г", text: "Перетерті томати, моцарела, прошутто котто, ковбаски, салямі на На ваш вибір - с гострим перцем або ні . Алергени: злаки, лактоза.", image: "il-macheljano", price: 325.00, category: "Pizza", options: [Addition(id: 17, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Капрічіоза", weight: "Вага 500 г", text: "Перетерті томати, артишоки, прошуто кото, оливки каламата, свіжі печериці, моцарела. Алергени: злаки, лактоза.", image: "kaprichioza", price: 289.00, category: "Pizza", options: [Addition(id: 18, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0)
        ]
    }
    
    func getFeaturedPromotions() {
        featuredPromotions = [
            Food(title: "THE BURGER", weight: "Вага 540 г", text: "Лосось, моцарела, рікота, пармезан, червона ікра, рукола. Алергени: злаки, лактоза, риба.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.", image: "THEBURGER", price: 330.00, category: "Burger", options: [Addition(id: 19, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            
            Food(title: "Тоскана", weight: "Вага 410 г", text: "Моцарела, білі гриби, рікота, пармезан. Алергени: злаки, лактоза.", image: "tockana", price: 325.00, category: "Pizza", options: [Addition(id: 20, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Пепероні", weight: "Вага 420 г", text: "Перетерті томати, моцарела, салямі пікантна пепероні. Алергени: злаки, лактоза.", image: "peperoni", price: 280.00, category: "Pizza", options: [Addition(id: 21, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Іль Мачельяно", weight: "Вага 470 г", text: "Перетерті томати, моцарела, прошутто котто, ковбаски, салямі на На ваш вибір - с гострим перцем або ні . Алергени: злаки, лактоза.", image: "il-macheljano", price: 325.00, category: "Pizza", options: [Addition(id: 22, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Капрічіоза", weight: "Вага 500 г", text: "Перетерті томати, артишоки, прошуто кото, оливки каламата, свіжі печериці, моцарела. Алергени: злаки, лактоза.", image: "kaprichioza", price: 289.00, category: "Pizza", options: [Addition(id: 23, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0)
        ]
    }
    
    func getContacts() {
        contacts = [Contacts(title: "Квартира/офіс", answer: ""), Contacts(title: "Під‘їзд", answer: ""), Contacts(title: "Поверх", answer: ""), Contacts(title: "Домофон", answer: ""), Contacts(title: "Ваше ім‘я", answer: ""), Contacts(title: "Телефон для зв‘язку", answer: ""), Contacts(title: "Кількість приборів", answer: "1"), Contacts(title: "Коментар", answer: "")]
        
    }
}

enum ModalEnum: String {
    case signIn
    case signUp
    case adress
    case date
    case payment
}
