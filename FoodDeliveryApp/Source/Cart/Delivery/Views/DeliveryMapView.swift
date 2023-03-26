//
//  LocationView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/17/23.
//

import SwiftUI
import MapKit

struct DeliveryMapView: View {
    @State var locationTitle: String?
    @State var subTitle: String?
    @State var showLocationSearchView = false
    
    @EnvironmentObject var model: Model
    @AppStorage("optionSelected") var optionSelected = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            DeliveryMapViewRepresentable(title: $locationTitle, subtitle: $subTitle)
                .ignoresSafeArea()
            
            VStack(spacing: 13) {
                LocationSearchActivationView(locationTitle: $locationTitle)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        showLocationSearchView.toggle()
                    }
                    .sheet(isPresented: $showLocationSearchView) {
                        LocationSearchView(locationTitle: $locationTitle, showLocationSearchView: $showLocationSearchView)
                    }
                confirmButton
            }
        }
    }
    
    var confirmButton: some View {
        Button {
            model.locationTimePayment[0].title = "Доставка"
            model.locationTimePayment[0].subtitle = locationTitle ?? "Адреса не вказана"
            optionSelected.toggle()
        } label: {
            Text("Доставка за цією адресою")
                .fontWeight(.bold)
        }
        .font(.headline)
        .tint(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.linearGradient(colors: [.purple, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .padding(.horizontal, 20)
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryMapView()
            .environmentObject(Model())
    }
}
