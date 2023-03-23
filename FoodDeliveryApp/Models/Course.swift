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
    Course(title: "SwiftUI for iOS 15", subtitle: "20 sections - 3 hours", text: "Build an iOS app for iOS 15 with custom layouts, animations and ...", image: "avocado", background: "Background 5", logo: "Logo 2"),
    Course(title: "UI Design for iOS 15", subtitle: "20 sections - 3 hours", text: "Design an iOS app for iOS 15 with custom layouts, animations and ...", image: "banner_2", background: "Background 4", logo: "Logo 4"),
    Course(title: "Flutter for designers", subtitle: "20 sections - 3 hours", text: "Flutter is a relatively new toolkit that makes it easy to build cross-platform apps that look gorgeous and is easy to use.", image: "banner_3", background: "Background 1", logo: "Logo 1"),
    Course(title: "React Hooks Advanced", subtitle: "20 sections - 3 hours", text: "Learn how to build a website with Typescript, Hooks, Contentful and Gatsby Cloud", image: "banner_4", background: "Background 2", logo: "Logo 3"),
]

var courses = [
    Course(title: "За кожне 2 замовлення", subtitle: "5 бонусів", text: "Build an iOS app for iOS 15 with custom layouts, animations and ...", image: "Illustration 9", background: "Background 5", logo: "Logo 2"),
    Course(title: "За замовлення від 1000 грн", subtitle: "20 sections - 3 hours", text: "Flutter is a relatively new toolkit that makes it easy to build cross-platform apps that look gorgeous and is easy to use.", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
    Course(title: "За замовлення з категорії 'Піца'", subtitle: "20 sections - 3 hours", text: "Flutter is a relatively new toolkit that makes it easy to build cross-platform apps that look gorgeous and is easy to use.", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
    Course(title: "За замовлення з категорії 'Бар'", subtitle: "20 sections - 3 hours", text: "Flutter is a relatively new toolkit that makes it easy to build cross-platform apps that look gorgeous and is easy to use.", image: "Illustration 1", background: "Background 1", logo: "Logo 1"),
]
