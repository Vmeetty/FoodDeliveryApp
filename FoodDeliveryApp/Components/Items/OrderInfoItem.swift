//
//  OrderInfoItem.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct OrderInfoItem: View {
    @Binding var infoItem: Info
    @Binding var showAlert: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: infoItem.icon)
                .frame(width: 36, height: 36)
                .background(.ultraThinMaterial)
                .mask(Circle())
            VStack(alignment: .leading, spacing: 6) {
                Text(infoItem.title)
                    .fontWeight(.bold)
                Text(infoItem.subtitle == "" ? "Інформація відсутня" : infoItem.subtitle)
                    .font(.footnote)
                    .tint(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            if infoItem.title == "Доставка" {
                Circle()
                    .foregroundColor(showAlert ? .pink : .secondary)
                    .frame(width: 7, height: 7)
            }
        }
    }
}

struct OrderInfoItem_Previews: PreviewProvider {
    static var previews: some View {
        OrderInfoItem(infoItem: .constant(Info(title: "Адреса", subtitle: "Авіаконструктора Сікорського 4Д", icon: "location", infoTab: .location)), showAlert: .constant(true))
    }
}
