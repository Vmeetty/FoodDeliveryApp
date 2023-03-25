//
//  DeliveryMapViewRepresentable.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/25/23.
//

import SwiftUI
import MapKit

struct DeliveryMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationSearchViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationSearchViewModel.selectedLocationCoordinate {
            print("DEBUG: selectedLocation - \(coordinate)")
            let newCoordinateRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            mapView.setRegion(newCoordinateRegion, animated: true)
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        MapCoordinator(parent: self)
    }
}

extension DeliveryMapViewRepresentable {
    
    // MARK: - Properties
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: DeliveryMapViewRepresentable
        
        // MARK: - LifeCircle
        init(parent: DeliveryMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        // MARK: - Helpers
    }
}
