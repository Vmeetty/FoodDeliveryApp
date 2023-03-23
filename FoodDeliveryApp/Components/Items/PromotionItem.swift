//
//  PromotionItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/23/23.
//

import SwiftUI

struct PromotionItem: View {
    var course: Course = promos[0]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .foregroundColor(.clear)
            .background(
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .mask {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
            }
            .frame(height: 230)
            .padding(20)
    }
}

struct PromotionItem_Previews: PreviewProvider {
    static var previews: some View {
        PromotionItem()
    }
}
