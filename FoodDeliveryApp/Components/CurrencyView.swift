//
//  LogoView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/6/23.
//

import SwiftUI

struct CurrencyView: View {
    
    var body: some View {
        Image(systemName: "hryvniasign")
//            .resizable()
            .frame(width: 26, height: 26)
            .cornerRadius(10)
            .padding(8)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 18, opacity: 0.4)
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
