//
//  MenuItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct MenuItem: View {
    var namespace: Namespace.ID
    var dish: Food
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(dish.title)
                    .font(.title).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .matchedGeometryEffect(id: "title\(dish.id)", in: namespace)
                    .foregroundColor(.white)
                HStack {
                    Image(systemName: "hryvniasign")
                        .padding(8)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .strokeStyle(cornerRadius: 12)
                        .matchedGeometryEffect(id: "currency\(dish.id)", in: namespace)
                    Text(dish.price)
                        .font(.title2)
                        .foregroundColor(.white)
                        .matchedGeometryEffect(id: "price\(dish.id)", in: namespace)
                }
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.black.opacity(0.4))
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .cornerRadius(30)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(dish.id)", in: namespace)
                    .opacity(0.8)
            )
        }
        .foregroundColor(.white)
        .background(
            Image(dish.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "image\(dish.id)", in: namespace)
        )
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
        MenuItem(namespace: namespace, dish: Food(title: "Маргарита", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "margarita", price: "185", category: "Pizza", options: [Addition(title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")])]))
    }
}
