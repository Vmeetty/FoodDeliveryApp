//
//  AnimatbleFontModifire.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/5/23.
//

import SwiftUI

struct AnimatbleFontModifire: AnimatableModifier {
    var size: Double
    var weight: Font.Weight = .regular
    var design: Font.Design = .default
    
    var animatableData: Double {
        get { size }
        set { size = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: weight, design: design))
    }
}
