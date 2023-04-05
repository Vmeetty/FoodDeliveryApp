//
//  Handbook.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/28/23.
//

import SwiftUI

//struct Handbook: Identifiable {
//    let id = UUID()
//    var title: String
//    var subtitle: String
//    var text: String
//    var logo: String
//    var image: String
//    var color1: Color
//    var color2: Color
//}
//
//var handbooks = [
//    Handbook(title: "SwiftUI Handbook", subtitle: "80 sections - 9 hours", text: "A comprehensive series of tutorials covering Xcode, SwiftUI and all the layout and development techniques", logo: "Logo 1", image: "Illustration 1", color1: .teal, color2: .blue),
//    Handbook(title: "React Advanced Handbook", subtitle: "30 sections - 3 hours", text: "A comprehensive guide for an overview of the React library and all its basics", logo: "Logo 1", image: "Illustration 2", color1: .purple, color2: .pink)
//]

struct Promo: Identifiable {
    let id = UUID()
    let image: String
    var color1: Color
    var color2: Color
}

var promos = [
    Promo(image: "Promo_1", color1: .teal, color2: .blue),
    Promo(image: "Promo_2", color1: .purple, color2: .pink)
]

struct BonusInfo: Identifiable {
    let id = UUID()
    let title: String
}

var bonusInfo = [
    BonusInfo(title: "30 балів - солодкий напій"),
    BonusInfo(title: "50 балів - солодкий круасан"),
    BonusInfo(title: "70 балів - кава на вибір"),
    BonusInfo(title: "125 балів - сніданок"),
    BonusInfo(title: "230 балів - бургер на вибір"),
]
