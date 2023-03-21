//
//  LocationView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/17/23.
//

import SwiftUI
import MapKit

struct DeliveryMapView: View {
    @State var circleColor: Color = .pink
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    @AppStorage("optionSelected") var optionSelected = false
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .tint(Color(.systemPink))
                .ignoresSafeArea()
                .grayscale(1)
                .onAppear {
                    locationManager.checkIfLocationServicesIsEnabled()
                }
                .onChange(of: locationManager.location) { newValue in
                    if let location = newValue {
                        let latitude = String(describing: location.coordinate.latitude)
                        let longitude = String(describing: location.coordinate.longitude)
                        locationManager.getAddressFromLatLon(pdblLatitude: latitude, withLongitude: longitude)
                    }
                }
            Button {
                model.locationTimePayment[0].title = "Доставка"
                model.locationTimePayment[0].subtitle = locationManager.adressStr
//                model.locationTimePayment[0].icon = item.icon
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
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.linearGradient(colors: [.purple, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal, 20)
            .offset(y: 70)
        }
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryMapView()
            .environmentObject(Model())
    }
}
