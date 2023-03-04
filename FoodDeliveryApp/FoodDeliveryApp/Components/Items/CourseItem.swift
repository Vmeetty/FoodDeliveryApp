//
//  CourseItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct CourseItem: View {
    var namespace: Namespace.ID
    var dish: Food
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(dish.title)
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title\(dish.id)", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                Text(dish.price)
//                    .font(.title2.weight(.semibold))
//                    .matchedGeometryEffect(id: "subtitle\(dish.id)", in: namespace)
//                Text(dish.text)
//                    .font(.footnote)
//                    .matchedGeometryEffect(id: "text\(dish.id)", in: namespace)
//                Divider()
//                    .frame(height: 0)
//                    .opacity(0)
//                    .matchedGeometryEffect(id: "divider", in: namespace)
                HStack {
                    Image(systemName: "hryvniasign")
//                        .resizable()
//                        .frame(width: 26, height: 26)
//                        .cornerRadius(10)
                        .padding(8)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .strokeStyle(cornerRadius: 18)
                    Text(dish.price)
                        .font(.title2)
                }
//
//                .opacity(0)
//                .frame(height: 0)
//                .matchedGeometryEffect(id: "nameAndAvatar", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.black)
                    .opacity(0.3)
                    .mask({
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    })
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(dish.id)", in: namespace)
            )
        }
        .foregroundColor(.white)
        .background(
            Image(dish.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "image\(dish.id)", in: namespace)
        )
//        .background(
//            Image(course.background)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
//        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(dish.id)", in: namespace)
        }
        .frame(height: 300)
        .padding(20)
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        CourseItem(namespace: namespace, dish: Food(title: "Маргарита", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "margarita", price: "185", category: "Pizza", options: [Option(title: "Гострий", values: ["Так", "Ні"])]), show: .constant(true))
    }
}
