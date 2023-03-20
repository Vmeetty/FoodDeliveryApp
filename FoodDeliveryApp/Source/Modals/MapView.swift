//
//  LocationView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/17/23.
//

import SwiftUI
import MapKit

struct MapView: View {
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
                model.locationTimePayment[0].subtitle = locationManager.adressStr
//                model.locationTimePayment[0].icon = item.icon
                optionSelected.toggle()
            } label: {
                Text("Доставка за цією адресою")
                    .fontWeight(.light)
            }
            .font(.headline)
            .tint(.white)
            .padding()
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(.black)
            )
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(20)
        }
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(Model())
    }
}
