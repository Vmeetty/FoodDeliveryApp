//
//  RestrantsMapView.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/21/23.
//

import SwiftUI
import MapKit

struct RestrantsMapView: View {
    
    @EnvironmentObject private var vm: MapsViewModel
    
    var body: some View {
        ZStack {
            restrantsMapLayer
                .ignoresSafeArea()
            
            if vm.mapLocation != nil {
                locationsPreviewStack
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: 100)
            } else {
                Text("Fetching of locations is failed")
                    .font(.title2)
                    .fontWeight(.black)
            }
        }
    }
}

extension RestrantsMapView {
    private var restrantsMapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
        .grayscale(1)
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    MapPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
        .padding()
    }
}

struct RestrantsMapView_Previews: PreviewProvider {
    static var previews: some View {
        RestrantsMapView()
            .environmentObject(MapsViewModel())
    }
}
