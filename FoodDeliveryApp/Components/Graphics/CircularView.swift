//
//  CircularView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct CircularView: View {
    var value: CGFloat = 0.2
    var lineWidth: CGFloat = 4
    @State var appeare = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: appeare ? value : 0)
            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
            .fill(.angularGradient(colors: [.purple, .pink, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .rotationEffect(.degrees(270))
            .onAppear {
                withAnimation(.spring().delay(0.5)) {
                    appeare = true
                }
            }
            .onDisappear {
                appeare = false
            }
    }
}

struct CircularView_Previews: PreviewProvider {
    static var previews: some View {
        CircularView()
    }
}
