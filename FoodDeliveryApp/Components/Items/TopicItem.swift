//
//  TopicItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct TopicItem: View {
    
    var topic: Topic = topics[0
    ]
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: topic.icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .mask(Circle())
            Text(topic.title)
                .fontWeight(.semibold)
            Spacer()
        }
    }
}

struct TopicItem_Previews: PreviewProvider {
    static var previews: some View {
        TopicItem()
    }
}
