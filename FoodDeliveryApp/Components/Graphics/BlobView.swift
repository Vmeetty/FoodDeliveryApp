//
//  BlobView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

struct BlobView: View {
    
    @State var appeare = false
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            let angel = Angle.degrees(now.remainder(dividingBy: 3) * 50)
            let x = cos(angel.radians)
            let angel2 = Angle.degrees(now.remainder(dividingBy: 6) * 2)
            let x2 = cos(angel2.radians)
            
            
            Canvas { context, size in
                context.fill(path(in: CGRect(x: 0, y: 0, width: size.width, height: size.height), x: x, x2: x2), with: .linearGradient(Gradient(colors: [.blue, .pink]), startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 400, y: 400)))
            }
            .frame(width: 386, height: 478)
            .rotationEffect(.degrees(appeare ? 360 : 0))
        }
        .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: true)) {
                appeare = true
            }
        }
    }
    
    func path(in rect: CGRect, x: Double, x2: Double) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.9923*width, y: 0.42593*height))
        path.addCurve(to: CGPoint(x: 0.6355*width*x2, y: height), control1: CGPoint(x: 0.92554*width*x2, y: 0.77749*height*x2), control2: CGPoint(x: 0.91864*width*x2, y: height))
        path.addCurve(to: CGPoint(x: 0.08995*width, y: 0.60171*height), control1: CGPoint(x: 0.35237*width*x, y: height), control2: CGPoint(x: 0.2695*width, y: 0.77304*height))
        path.addCurve(to: CGPoint(x: 0.34086*width, y: 0.06324*height*x), control1: CGPoint(x: -0.0896*width, y: 0.43038*height), control2: CGPoint(x: 0.00248*width, y: 0.23012*height*x))
        path.addCurve(to: CGPoint(x: 0.9923*width, y: 0.42593*height), control1: CGPoint(x: 0.67924*width, y: -0.10364*height*x), control2: CGPoint(x: 1.05906*width, y: 0.07436*height*x2))
        path.closeSubpath()
        return path
    }
}

struct BlobView_Previews: PreviewProvider {
    static var previews: some View {
        BlobView()
    }
}

struct BlobShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.95475*width, y: 0.44317*height))
        path.addCurve(to: CGPoint(x: 0.81565*width, y: height), control1: CGPoint(x: 0.95475*width, y: 0.69004*height), control2: CGPoint(x: 1.12119*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.38314*height), control1: CGPoint(x: 0.5101*width, y: height), control2: CGPoint(x: 0, y: 0.63001*height))
        path.addCurve(to: CGPoint(x: 0.70183*width, y: 0), control1: CGPoint(x: 0, y: 0.13627*height), control2: CGPoint(x: 0.39628*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.95475*width, y: 0.44317*height), control1: CGPoint(x: 1.00738*width, y: 0), control2: CGPoint(x: 0.95475*width, y: 0.1963*height))
        path.closeSubpath()
        return path
    }
}
