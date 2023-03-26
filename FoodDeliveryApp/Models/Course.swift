//
//  Course.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/5/23.
//

import Foundation

struct Course: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String
}

var featuredCourses = [
    Course(title: "Даруємо Маргариту", subtitle: "20 sections - 3 hours", text: "До замовлення від 650 грн на самовиніс", image: "pizza", background: "Background 5", logo: "Logo 2"),
    Course(title: "Даруємо Хумус", subtitle: "20 sections - 3 hours", text: "До замовлення від 450грн на самовиніс", image: "humus", background: "Background 4", logo: "Logo 4"),
    Course(title: "Літній салат даром", subtitle: "20 sections - 3 hours", text: "На кожне 3 замовлення даруємо велику порцію салату", image: "salad", background: "Background 1", logo: "Logo 1"),
]

var courses = [
    Course(title: "За кожне 2 замовлення", subtitle: "10", text: "Build an iOS app for iOS 15 with custom layouts, animations and ...", image: "Illustration 9", background: "Background 5", logo: "Logo 2"),
    Course(title: "За замовлення від 1000 грн", subtitle: "20", text: "Flutter is a relatively new toolkit that makes it easy to build cross-platform apps that look gorgeous and is easy to use.", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
    Course(title: "За замовлення з категорії 'Піца'", subtitle: "5", text: "Flutter is a relatively new toolkit that makes it easy to build cross-platform apps that look gorgeous and is easy to use.", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
    Course(title: "За замовлення з категорії 'Бар'", subtitle: "7", text: "Flutter is a relatively new toolkit that makes it easy to build cross-platform apps that look gorgeous and is easy to use.", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
]
