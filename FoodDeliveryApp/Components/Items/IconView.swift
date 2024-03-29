//
//  IconView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/24/23.
//

import SwiftUI

struct IconView: View {
    var image = ""
    
    var body: some View {
        Image(systemName: image)
            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(8)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 18, opacity: 0.4)
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView()
    }
}
