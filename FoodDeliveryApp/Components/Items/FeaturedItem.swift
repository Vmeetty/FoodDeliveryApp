//
//  FeaturedItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/23/23.
//

import SwiftUI

struct FeaturedItem: View {
    var course: Course = homePromotions[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Spacer()
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(course.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text(course.text)
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                }
                Color.clear
            }
        }
        .padding(.all, 20.0)
//        .padding(.vertical, 20.0)
        .frame(height: 210.0)
        .background(.ultraThinMaterial)
        .mask({
            RoundedRectangle(cornerRadius: 30.0, style: .continuous)
        })
        .strokeStyle()
        .padding(.horizontal, 20.0)
    }
}

struct FeaturedItem_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedItem()
    }
}
