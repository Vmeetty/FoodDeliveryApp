//
//  PaymentTypeView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/17/23.
//

import SwiftUI

struct PaymentTypeView: View {
    enum Option {
        case cash
        case card
    }
    
    @State var selected: Option = .cash
    @State var circleColor: Color = .blue
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    @AppStorage("optionSelected") var optionSelected = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Оберіть спосіб оплати")
                .font(.headline)
                .opacity(appear[1] ? 1 : 0)
                .offset(y: appear[1] ? 0 : 20)
            
            Divider()
            
            Group {
                Text("Готівкою при одержані")
                    .checkStyle(icon: "banknote.fill")
                    .shadow(color: .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .overlay {
                        if selected == .cash {
                            Image(systemName: "checkmark")
                                .tint(Color.white)
                                .frame(width: 21, height: 21)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding()
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onTapGesture {
                        selected = .cash
                        optionSelected.toggle()
                    }
                
                Text("Карткою при одержані")
                    .checkStyle(icon: "creditcard.fill")
                    .shadow(color: .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .overlay {
                        if selected == .card {
                            Image(systemName: "checkmark")
                                .tint(Color.white)
                                .frame(width: 21, height: 21)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding()
                        }
                    }
                    .onTapGesture {
                        selected = .card
                        optionSelected.toggle()
                    }
            }
            .opacity(appear[2] ? 1 : 0)
            .offset(y: appear[2] ? 0 : 20)
            
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .background(
            Circle().fill(circleColor)
                .frame(width: 68, height: 68)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .opacity(appear[2] ? 1 : 0)
        )
        .coordinateSpace(name: "container")
        .strokeStyle(cornerRadius: 30)
        .onAppear {
            withAnimation(.spring().delay(0.1)) {
                appear[0] = true
            }
            withAnimation(.spring().delay(0.2)) {
                appear[1] = true
            }
            withAnimation(.spring().delay(0.3)) {
                appear[2] = true
            }
        }
    }
    
    var geometry: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: CirclePreferenceKey.self, value: proxy.frame(in: .named("container")).minY)
        }
    }
}

struct PaymentTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentTypeView()
            .environmentObject(Model())
    }
}
