//
//  MapPopUpView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/20/23.
//

import SwiftUI

struct MapPopUpView: View {
    @EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero
    @State var isDismiss = false
    @State var appear = [false, false, false]
    @AppStorage("optionSelected") var optionSelected = false
    
    var body: some View {
        ZStack {
            Color.clear.background(.regularMaterial)
                .ignoresSafeArea()
                .opacity(0.8)
                .onTapGesture {
                    dismissModal()
                }
            
            MapView()
            
            Button {
                dismissModal()
            } label: {
                Image(systemName: "xmark")
                    .font(.body.weight(.bold))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
        }
//        .ignoresSafeArea()
        .onChange(of: optionSelected) { newValue in
            dismissModal()
        }
    }
    
    func dismissModal() {
        withAnimation {
            isDismiss = true
        }
        withAnimation(.linear.delay(0.3)) {
            model.showMap = false
        }
    }
}

struct MapPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        MapPopUpView()
    }
}
