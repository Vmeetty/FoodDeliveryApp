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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(dish.title)
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(3)
                    .matchedGeometryEffect(id: "title\(dish.id)", in: namespace)
                    .foregroundColor(.primary)
                HStack {
                    IconView(image: "hryvniasign.circle")
                        .matchedGeometryEffect(id: "currency\(dish.id)", in: namespace)
                    Text(String(format: "%.2f", dish.price))
                        .font(.body)
                        .foregroundColor(.primary)
                        .matchedGeometryEffect(id: "price\(dish.id)", in: namespace)
                }
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .cornerRadius(30)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(dish.id)", in: namespace)
                    .opacity(0.6)
            )
        }
        .background(
            Image(dish.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .disabled(true)
                .matchedGeometryEffect(id: "background\(dish.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30)
                .matchedGeometryEffect(id: "mask\(dish.id)", in: namespace)
        )
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        MenuItem(namespace: namespace, dish: Food(title: "MIAMI", weight: "Вага 340 г", text: "Перетерті томати, моцарела, базилік. Алергени: злаки, лактоза.", image: "MIAMI", price: 430.00, category: "Burger", options: [Addition(id: 3, title: "Гострий", values: [AdditionItem(title: "Так"), AdditionItem(title: "Ні")]), Addition(id: 4, title: "Бекон", values: [AdditionItem(title: "3гр", price: "10"), AdditionItem(title: "7гр", price: "15")])], countSelected: 0))
    }
}

/*
 var body: some View {
     VStack {
         Spacer()
         VStack(alignment: .leading, spacing: 12) {
             Text(dish.title)
                 .font(.title).bold()
                 .frame(maxWidth: .infinity, alignment: .leading)
                 .foregroundColor(.primary)
                 .matchedGeometryEffect(id: "title\(dish.id)", in: namespace)
             HStack {
                 Image(systemName: "hryvniasign")
                     .padding(8)
                     .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                     .strokeStyle(cornerRadius: 12)
                     .matchedGeometryEffect(id: "currency\(dish.id)", in: namespace)
                 Text(String(format: "%.2f", dish.price))
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
                 .opacity(0.6)
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
     .overlay {
     }
 }
 */
