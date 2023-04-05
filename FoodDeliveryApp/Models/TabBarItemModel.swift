//
//  TabBarItemModel.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/4/23.
//

import SwiftUI

struct TabBarItemModel: Identifiable {
    var id = UUID()
    var title: String
    var imageName: String
    var tab: Tab
    var color: Color
}

var tabBarItems = [
    TabBarItemModel(title: "Меню", imageName: "menucard.fill", tab: .home, color: .teal),
    TabBarItemModel(title: "Акції", imageName: "star.fill", tab: .explore, color: .blue),
    TabBarItemModel(title: "Кошик", imageName: "cart.fill", tab: .notifications, color: .pink),
    TabBarItemModel(title: "Історія", imageName: "bag.fill", tab: .library, color: .yellow)
]

enum Tab: String {
    case home, explore, notifications, library
}
