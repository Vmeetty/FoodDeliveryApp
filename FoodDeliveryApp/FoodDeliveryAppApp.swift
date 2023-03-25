//
//  FoodDeliveryAppApp.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/2/23.
//

import SwiftUI

@main
struct FoodDeliveryAppApp: App {
    @StateObject var model = Model()
    @StateObject var mapsViewModel = MapsViewModel()
    @StateObject var locationSearchViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(mapsViewModel)
                .environmentObject(locationSearchViewModel)
        }
    }
}
