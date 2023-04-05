//
//  MapView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/20/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject private var vm: MapsViewModel
    @State var isDismiss = false
    @State var appear = [false, false, false]
    @AppStorage("optionSelected") var optionSelected = false
    
    var body: some View {
        ZStack {
            if vm.deliveryButtonPressed {
                DeliveryMapView()
            }
            
            if vm.selfPickUpButtonPressed {
                RestrantsMapView()
            }
            
            header
        }
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

extension MapView {
    private var header: some View {
        VStack {
            HStack {
                selfPickUpButton
                deliveryButton
                closeButton
            }
        }
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
    private var selfPickUpButton: some View {
        Button {
            vm.deliveryButtonPressed = false
            vm.selfPickUpButtonPressed = true
        } label: {
            Text("Самовивіз")
                .frame(width: 125, height: 35)
        }
        .font(.headline)
        .tint(.white)
        .padding()
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(vm.selfPickUpButtonPressed ? .purple : .secondary)
        )
    }
    
    private var deliveryButton: some View {
        Button {
            vm.deliveryButtonPressed = true
            vm.selfPickUpButtonPressed = false
        } label: {
            Text("Доставка")
                .frame(width: 125, height: 35)
        }
        .font(.headline)
        .tint(.white)
        .padding()
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(vm.deliveryButtonPressed ? .purple : .secondary)
        )
    }
    
    private var closeButton: some View {
        HStack {
            Button {
                dismissModal()
            } label: {
                Image(systemName: "xmark")
                    .font(.title2.weight(.light))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(.ultraThinMaterial, in: Circle())
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(MapsViewModel())
    }
}
