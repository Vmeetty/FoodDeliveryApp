//
//  LocationView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/17/23.
//

import SwiftUI
import MapKit

struct DeliveryMapView: View {
//    @State var circleColor: Color = .pink
//    @State var appear = [false, false, false]
    @State var locationTitle: String?
    @EnvironmentObject var model: Model
    @AppStorage("optionSelected") var optionSelected = false
//
//    @StateObject var locationManager = OldLocationManager()
    
    @State var showLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
//            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
//                .tint(Color(.systemPink))
//                .ignoresSafeArea()
////                .grayscale(1)
//                .onAppear {
//                    locationManager.checkIfLocationServicesIsEnabled()
//                }
//                .onChange(of: locationManager.location) { newValue in
//                    if let location = newValue {
//                        let latitude = String(describing: location.coordinate.latitude)
//                        let longitude = String(describing: location.coordinate.longitude)
//                        locationManager.getAddressFromLatLon(pdblLatitude: latitude, withLongitude: longitude)
//                    }
//                }
            DeliveryMapViewRepresentable()
                .ignoresSafeArea()
            
            VStack(spacing: 13) {
                
                confirmButton
                
                LocationSearchActivationView(locationTitle: $locationTitle)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        showLocationSearchView.toggle()
                    }
                    .sheet(isPresented: $showLocationSearchView) {
                        LocationSearchView(locationTitle: $locationTitle, showLocationSearchView: $showLocationSearchView)
                    }
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
