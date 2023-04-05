//
//  PlayView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct PlayView: View {
    var body: some View {
        PlayShape()
            .fill(Color("Shadow").opacity(0.8))
            .frame(width: 25, height: 25)
            .background(
                PlayShape()
                    .fill(.angularGradient(colors: [.blue, .red, .blue], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                    .blur(radius: 12)
            )
            .offset(x: 3)
            .frame(width: 60, height: 60)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
            .strokeStyle(cornerRadius: 25)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 10, x: 0, y: 9)
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
