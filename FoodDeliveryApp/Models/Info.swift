//
//  Info.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/28/23.
//

import SwiftUI

struct Info: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var icon: String
    var infoTab: InfoTab
}

var locationTimePayment = [
    Info(title: "Адреса", subtitle: "Авіаконструктора Сікорського 4Д", icon: "location", infoTab: .location),
    Info(title: "Час доставки", subtitle: "Бер 12, 11:10 - 11:25", icon: "clock", infoTab: .time),
    Info(title: "Оберіть спосіб оплати", subtitle: "Готівкою при одержанні", icon: "creditcard", infoTab: .payment)
]

enum InfoTab {
    case location, time, payment
}
