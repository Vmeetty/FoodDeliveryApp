//
//  DeliveryMapViewRepresentable.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/25/23.
//

import SwiftUI
import MapKit

struct DeliveryMapViewRepresentable: UIViewRepresentable {
    
    @Binding var title: String?
    @Binding var subtitle: String?
    
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
    
    // update region everytime we set new coordinate by LocationSearchView or loading mapview
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationSearchViewModel.selectedLocationCoordinate {
            let newCoordinateRegion = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
            mapView.setRegion(newCoordinateRegion, animated: true)
            context.coordinator.addAnnotation(withCoordinate: coordinate)
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
        // calling one time when detecting current user location
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            reverseGeocode(location: location)
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pin.isDraggable = true
            pin.tintColor = .systemPink
            pin.animatesDrop = true
            
            return pin
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            
            guard let latitude = view.annotation?.coordinate.latitude else { return }
            guard let longitude = view.annotation?.coordinate.longitude else { return }
            let location: CLLocation = CLLocation(latitude:latitude, longitude: longitude)
            
            if newState == .ending {
                parent.locationSearchViewModel.selectedLocationCoordinate = location.coordinate
            }
            
            reverseGeocode(location: location)
        }
      
        // MARK: - Helpers
        
        func addAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.showsUserLocation = false
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
        
        func reverseGeocode(location: CLLocation) {
            CLGeocoder().reverseGeocodeLocation(location) { places, error in
                if let places = places {
                    self.parent.title = places.first?.name
                    self.parent.subtitle = places.first?.locality
                }
            }
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
