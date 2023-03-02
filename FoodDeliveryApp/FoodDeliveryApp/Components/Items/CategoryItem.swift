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
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: category.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundColor(selectedId == category.id ? .white : .secondary)
            
            Text(category.title)
                .font(.footnote)
                .fontWeight(.regular)
                .layoutPriority(1)
                .foregroundColor(selectedId == category.id ? .white : .secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.linearGradient(colors: [Color("Blue"), Color("Blue")], startPoint: .topLeading, endPoint: .bottomTrailing))
                .opacity(selectedId == category.id ? 1 : 0)
        )
        .shadow(color: Color.ShadowColor.opacity(selectedId == category.id ? 0.3 : 0.0), radius: 7, x: 0, y: 5)
        .frame(maxWidth: 100)
        .frame(width: 80)
        .frame(height: 100)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(category: Category(title: "Pizza", icon: "eyedropper"), selectedId: .constant(UUID()))
    }
}
