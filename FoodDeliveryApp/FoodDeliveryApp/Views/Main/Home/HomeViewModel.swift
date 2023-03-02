//
//  HomeViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var show = false
    @Published var hasScrolled = false
    @Published var showStatusBar = true
    @Published var showFeaturedCourse = false
    @Published var selectedCategoryIndex = 0
    @Published var fullMenu: [String : Any] = [:]
    
    func getMenu() -> [String : Any] {
        var firstCollection = [
            Food(title: "THE BURGER", weight: "Вага 540 г", text: "Лосось, моцарела, рікота, пармезан, червона ікра, рукола. Алергени: злаки, лактоза, риба.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.Лосось, моцарела, рікота, пармезан, червона ікра, рукола.", image: "THEBURGER", price: "330"),
            Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: "430"),
            Food(title: "COLORADO", weight: "Вага 430 г", text: "Моцарела, мінітомати, рукола, пармезан. Алергени: злаки, лактоза.", image: "COLORADO", price: "350"),
            Food(title: "TENNESSE", weight: "Вага 340 г", text: "Моцарела, горгонзола, пармезан, проволоне. Алергени: злаки, лактоза.", image: "TENNESSE", price: "360"),
            Food(title: "NEW ORLEANS", weight: "Вага 410 г", text: "Моцарела, білі гриби, рікота, пармезан. Алергени: злаки, лактоза.", image: "NEW ORLEANS", price: "290"),
            Food(title: "SUPREME NACHO", weight: "Вага 420 г", text: "Перетерті томати, моцарела, салямі пікантна пепероні. Алергени: злаки, лактоза.", image: "SUPREME NACHO", price: "360"),
            Food(title: "NEW YORK", weight: "Вага 470 г", text: "Перетерті томати, моцарела, прошутто котто, ковбаски, салямі на На ваш вибір - с гострим перцем або ні . Алергени: злаки, лактоза.", image: "NEW YORK", price: "340"),
            Food(title: "ARKANSAS", weight: "Вага 500 г", text: "Перетерті томати, артишоки, прошуто кото, оливки каламата, свіжі печериці, моцарела. Алергени: злаки, лактоза.", image: "ARKANSAS", price: "270")
        ]
        var secondCollection = [
            Food(title: "Селмон", weight: "Вага 540 г", text: "Лосось, моцарела, рікота, пармезан, червона ікра, рукола. Алергени: злаки, лактоза, риба.", image: "calmone", price: "385"),
            Food(title: "Маргарита", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "margarita", price: "185"),
            Food(title: "Капрезе", weight: "Вага 430 г", text: "Моцарела, мінітомати, рукола, пармезан. Алергени: злаки, лактоза.", image: "kapreze", price: "265"),
            Food(title: "Кватро Формаджі", weight: "Вага 340 г", text: "Моцарела, горгонзола, пармезан, проволоне. Алергени: злаки, лактоза.", image: "kvattro-formadzhi", price: "275"),
            Food(title: "Тоскана", weight: "Вага 410 г", text: "Моцарела, білі гриби, рікота, пармезан. Алергени: злаки, лактоза.", image: "tockana", price: "325"),
            Food(title: "Пепероні", weight: "Вага 420 г", text: "Перетерті томати, моцарела, салямі пікантна пепероні. Алергени: злаки, лактоза.", image: "peperoni", price: "280"),
            Food(title: "Іль Мачельяно", weight: "Вага 470 г", text: "Перетерті томати, моцарела, прошутто котто, ковбаски, салямі на На ваш вибір - с гострим перцем або ні . Алергени: злаки, лактоза.", image: "il-macheljano", price: "325"),
            Food(title: "Капрічіоза", weight: "Вага 500 г", text: "Перетерті томати, артишоки, прошуто кото, оливки каламата, свіжі печериці, моцарела. Алергени: злаки, лактоза.", image: "kaprichioza", price: "289"),
        ]
        return ["first": firstCollection, "second": secondCollection]
    }
    
}
