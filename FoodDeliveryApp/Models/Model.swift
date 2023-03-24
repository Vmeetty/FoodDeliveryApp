//
//  Model.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/6/23.
//

import Foundation

enum ModalEnum: String {
    case signIn
    case signUp
}

enum PopUpEnum: String {
    case location
    case date
    case payment
}

class Model: ObservableObject {
    // MARK: properties
    @Published var showDetail = false
    @Published var showPopUp = false
    @Published var showMap = false
    @Published var selectedModalView: ModalEnum = .signIn
    @Published var selectedPopUpView: PopUpEnum = .location
    // Tab Bar
    @Published var showTab: Bool = true
    
    // Navigation Bar
    @Published var showNav: Bool = true
    
    @Published var categories: [Category] = []
    @Published var fullMenu: [Food] = []
    @Published var featuredPromotions: [Food] = []
    
    // MARK: Cart
    @Published var orderItems: [Food] = []
    @Published var locationTimePayment: [Info] = []
    @Published var paymentIndexSelected: Int = 0
    @Published var contacts: [Contacts] = []
    @Published var calculations: [Calculation] = []
    @Published var rateValue: Int = 0
    @Published var ordersHistory: [SubmitedOrder] = []
    
    init() {
        getCategories()
        getMenu()
        getContacts()
        getInfo()
    }
    
    //MARK: methods
    func getCategories() {
        categories = [
            Category(title: "Burger", icon: "heart.circle.fill"),
            Category(title: "Pizza", icon: "eyedropper"),
            Category(title: "Soup", icon: "laptopcomputer"),
            Category(title: "Salat", icon: "iphone"),
            Category(title: "Bar", icon: "eyedropper"),
            Category(title: "Sushi", icon: "laptopcomputer"),
        ]
    }
    
    func getMenu() {
        fullMenu = [
            Food(title: "Ранкова булочка з рваною індичкою", weight: "Вага 540 г", text: "Рвана індичка, турецький йогурт, соус чермула, свіжі овочі та дайкон", image: "burg_0", price: 270.00, category: "Burger", options: [Addition(id: 1, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 1, title: "Бекон", values: [AdditionItem(title: "5гр", price: "15"), AdditionItem(title: "10гр", price: "25")])], countSelected: 0),
            Food(title: "Ранкова булочка з м’ясом", weight: "Вага 540 г", text: "З телятиною, овочами, чедером, яйцем, фетою, айолі та солодким чилі-соусом", image: "burg_1", price: 265.00, category: "Burger", options: [Addition(id: 1, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 2, title: "Бекон", values: [AdditionItem(title: "5гр", price: "15"), AdditionItem(title: "10гр", price: "25")])], countSelected: 0),
            Food(title: "Ранкова булочка з хрусткою куркою", weight: "Вага 340 г", text: "З  хрусткою курочкою тонкацу, овочами, фетою, айолі та солодким чилі-соусом", image: "burg_2", price: 265.00, category: "Burger", options: [Addition(id: 3, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 4, title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 0),
            Food(title: "Ранкова булочка з сиром", weight: "Вага 430 г", text: "З халумі, камамбером, фетою, айолі та джемом з чорної смородини", image: "burg_3", price: 235.00, category: "Burger", options: [Addition(id: 5, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Ранкова булочка з джемом та маслом", weight: "Вага 340 г", text: "Булочка бріош, смородиновий та грушевий джем, вершкове масло", image: "burg_4", price: 70.00, category: "Burger", options: [Addition(id: 6, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
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
            Food(title: "Капрічіоза", weight: "Вага 500 г", text: "Перетерті томати, артишоки, прошуто кото, оливки каламата, свіжі печериці, моцарела. Алергени: злаки, лактоза.", image: "kaprichioza", price: 289.00, category: "Pizza", options: [Addition(id: 18, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Гарбузовий суп", weight: "Вага 500 г", text: "Гарбуз, мигдалеве молоко, кориця, насіння гарбуза, сумах. Подаємо з бріошем.", image: "soup_1", price: 135.00, category: "Soup", options: [Addition(id: 19, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Сочевичний суп", weight: "Вага 500 г", text: "З сочевицею, шпинатом та оливками-гриль.", image: "soup_2", price: 125.00, category: "Soup", options: [Addition(id: 20, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
            Food(title: "Бульйон, що зцілює", weight: "Вага 500 г", text: "Курячий бульйон з яйцем та локшиною", image: "soup_3", price: 125.00, category: "Soup", options: [Addition(id: 21, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])], countSelected: 0),
        ]
    }
    
    func getContacts() {
        contacts = [Contacts(title: "Квартира/офіс", answer: ""), Contacts(title: "Під‘їзд", answer: ""), Contacts(title: "Поверх", answer: ""), Contacts(title: "Домофон", answer: ""), Contacts(title: "Ваше ім‘я", answer: ""), Contacts(title: "Телефон для зв‘язку", answer: ""), Contacts(title: "Прибори", answer: "1"), Contacts(title: "Коментар", answer: "")]
        
    }
    
    func getInfo() {
        locationTimePayment = [
            Info(title: "Доставка", subtitle: "Вкажіть адресу доставки", icon: "location", infoTab: .location),
            Info(title: "Час отримання", subtitle: "Бер 12, 11:10 - 11:25", icon: "clock", infoTab: .time),
            Info(title: "Cпосіб оплати", subtitle: "Готівкою при одержанні", icon: "creditcard", infoTab: .payment)
        ]
    }
}
