//
//  OrderInfoItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct OrderInfoItem: View {
    
    var topic: Topic = topics[0]
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: topic.icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .mask(Circle())
            VStack(alignment: .leading, spacing: 6) {
                Text(topic.title)
                    .fontWeight(.bold)
                Text(topic.subtitle)
                    .font(.footnote)
                    .tint(.secondary)
            }
            Spacer()
        }
    }
}

struct TopicItem_Previews: PreviewProvider {
    static var previews: some View {
        OrderInfoItem()
    }
}
