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
            .frame(width: 52, height: 52)
            .background(
                PlayShape()
                    .fill(.angularGradient(colors: [.blue, .red, .blue], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
                    .blur(radius: 12)
            )
            .offset(x: 3)
            .overlay(content: {
                PlayShape().stroke(.white)
            })
            .frame(width: 120, height: 120)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 46, style: .continuous))
            .strokeStyle(cornerRadius: 46)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
            .overlay {
                Text("12:08")
                    .font(.footnote.weight(.semibold))
                    .padding(.vertical, 2)
                    .padding(.horizontal, 4)
                    .background(Color(UIColor.systemBackground).opacity(0.3))
                    .cornerRadius(4)
                    .offset(y: 44)
            }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView()
    }
}
