//
//  HandbookItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct HandbookItem: View {
    
    var promo: Promo = promos[0]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.black.opacity(0.2))
            .frame(height: 250)
            .overlay {
                Image(promo.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .mask {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                    }
            }
        .padding()
        .frame(width: 270)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.linearGradient(colors: [promo.color1, promo.color2], startPoint: .topLeading, endPoint: .bottomTrailing))
                .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
                .rotationEffect(.degrees(180))
                .padding(.trailing, 40)
        )
    }
}

struct HandbookItem_Previews: PreviewProvider {
    static var previews: some View {
        HandbookItem(promo: promos[1])
    }
}

/*
 Image(promo.image)
     .resizable()
     .aspectRatio(contentMode: .fill)
     .frame(width: 350, height: 250)
     .mask {
         RoundedRectangle(cornerRadius: 30, style: .continuous)
             .padding(.trailing, 40)
     }
     .background {
         RoundedRectangle(cornerRadius: 30, style: .continuous)
             .fill(.linearGradient(colors: [promo.color1, promo.color2], startPoint: .topLeading, endPoint: .bottomTrailing))
             .rotation3DEffect(.degrees(10), axis: (x: 0, y: 1, z: 0), anchor: .bottomTrailing)
             .rotationEffect(.degrees(180))
             .padding(.trailing, 40)
     }
 }
 */
