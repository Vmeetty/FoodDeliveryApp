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
        mapView.userTrackingMode = .none
        mapView.showsUserLocation = true
        
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
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            //            getAddressFromLatLon(pdblLatitude: String(latitude), withLongitude: String(longitude))
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
        
        func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            guard let lat: Double = Double("\(pdblLatitude)") else { return }
            guard let lon: Double = Double("\(pdblLongitude)") else { return }
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon
            
            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
            
            ceo.reverseGeocodeLocation(loc, completionHandler:
                                        {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                if let pm = placemarks as? [CLPlacemark] {
                    
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        var addressString : String = ""
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.subThoroughfare != nil {
                            addressString = addressString + pm.subThoroughfare!
                        }
                        
                        //                            self.parent.locationSearchViewModel.locationTitle = addressString
                    }
                } else {
                    print("Show alert that app can't get user location. Check your internet connection")
                }
                
            })
            
        }
    }
}
