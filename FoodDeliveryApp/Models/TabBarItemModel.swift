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
    TabBarItemModel(title: "Меню", imageName: "house", tab: .home, color: .teal),
    TabBarItemModel(title: "Бали", imageName: "magnifyingglass", tab: .explore, color: .blue),
    TabBarItemModel(title: "Корзина", imageName: "bell", tab: .notifications, color: .pink),
    TabBarItemModel(title: "Акції", imageName: "rectangle.stack", tab: .library, color: .yellow)
]

enum Tab: String {
    case home, explore, notifications, library
}
