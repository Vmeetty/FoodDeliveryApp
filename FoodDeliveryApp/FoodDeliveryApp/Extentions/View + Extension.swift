//
//  View + Extension.swift
//  DesignCodeiOS15
//
//  Created by admin on 2/4/23.
//

import SwiftUI

extension View {
    func strokeStyle(cornerRadius: CGFloat = 30.0) -> some View {
        modifier(StrokeModifire(cornerRadius: cornerRadius))
    }
}

extension View {
    func animatbleFont(size: Double, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatbleFontModifire(size: size, weight: weight, design: design))
    }
}
