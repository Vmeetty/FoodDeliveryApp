//
//  MapsViewModel.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/21/23.
//

import MapKit
import SwiftUI

class MapsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location
    @Published var mapLocation: Location? {
        didSet {
            updateMapRegion(location: mapLocation!)
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationsList = false
    
    @Published var selfPickUpButtonPressed = true
    @Published var deliveryButtonPressed = false
    
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        if let firstLocation = locations.first {
            self.mapLocation = firstLocation
            updateMapRegion(location: firstLocation)
        } else {
            print("Add alert, that there is no locations on the map")
        }
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen")
            return
        }
        
        // Check if the next index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is not valid
            // Restart from 0
            guard let firstLocation = locations.first else {
                print("There is no locations")
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
