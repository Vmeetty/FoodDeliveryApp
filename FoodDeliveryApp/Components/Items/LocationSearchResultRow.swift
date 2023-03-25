//
//  LocationSearchResultRow.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/25/23.
//

import SwiftUI

struct LocationSearchResultRow: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.pink)
                .tint(.white)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultRow_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultRow(title: "Very Well", subtitle: "Сікорського 1а")
    }
}
