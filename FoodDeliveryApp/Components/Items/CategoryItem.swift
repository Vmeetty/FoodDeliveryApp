//
//  CategoryItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct CategoryItem: View {
    
    var category: Category
    @Binding var selectedId: UUID
    
    var body: some View {
        if selectedId == category.id {
            LinearGradient(gradient: Gradient(colors: [.purple, .orange, .purple]), startPoint: .top, endPoint: .bottom)
                .mask {
                    VStack(alignment: .center, spacing: 10) {
                        Image(systemName: category.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32, height: 32)
                        
                        Text(category.title)
                            .font(.footnote)
                            .fontWeight(.regular)
                            .layoutPriority(1)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 34, style: .continuous)
                        .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .fill(.angularGradient(colors: [.purple, .orange, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                )
                .shadow(color: Color.ShadowColor.opacity(0.1), radius: 5, x: 0, y: 1)
                .frame(maxWidth: 100)
                .frame(width: 80)
                .frame(height: 100)
        } else {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: category.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.secondary)
                    .frame(width: 32, height: 32)
                
                Text(category.title)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .layoutPriority(1)
                    .foregroundColor(.secondary)
            }
//            .padding()
            .frame(maxWidth: 100)
            .frame(width: 80)
            .frame(height: 100)
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(category: Category(title: "Pizza", icon: "heart.circle.fil"), selectedId: .constant(UUID()))
    }
}
