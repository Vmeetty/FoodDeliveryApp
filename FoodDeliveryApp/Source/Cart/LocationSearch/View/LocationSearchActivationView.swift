//
//  LocationSearchActivationView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/25/23.
//

import SwiftUI

struct LocationSearchActivationView: View {
    @Binding var locationTitle: String?
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.black)
                .frame(width: 8, height: 8)
                .padding(.horizontal, 20)
                .padding(.leading, 10)
            
            
            Text(locationTitle ?? "Вкажіть адресу")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(Color.white)
                .opacity(0.8)
                .shadow(radius: 6)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView(locationTitle: .constant("Вкажіть адресу"))
    }
}
