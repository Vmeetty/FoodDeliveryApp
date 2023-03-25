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
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationSearchViewModel.selectedLocationCoordinate {
            let newCoordinateRegion = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
            mapView.setRegion(newCoordinateRegion, animated: true)
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
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
            let coordinate = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            parent.mapView.setRegion(region, animated: true)
            addAndSelectAnnotation(withCoordinate: coordinate)
        }
        
        // MARK: - Helpers
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
    }
}
