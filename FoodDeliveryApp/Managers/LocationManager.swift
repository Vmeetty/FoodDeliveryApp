//
//  LocationManager.swift
//  FoodDeliveryApp
//
//  Created by admin on 3/19/23.
//

import MapKit

final class LocationManager: NSObject, ObservableObject {
    
    @Published var location: CLLocation?
    @Published var showingAlert = false
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.450001, longitude: 30.523333), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    @Published var adressStr = ""
    
    var locationManager: CLLocationManager?
    
//    override init() {
//        super.init()
//        checkIfLocationServicesIsEnabled()
//    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Showing an alert letting them know this is off and to go turn it on.")
        }
//        DispatchQueue.global().async {
//        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            showingAlert = true
            print("User location is restricted. Show alert.")
        case .denied:
            showingAlert = true
            print("User have denied this app location permission. Show alert with 'Allow' button into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            showingAlert = false
            if let location = locationManager.location {
                self.location = location
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            }
        @unknown default:
            break
        }
    }
    
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
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
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.subThoroughfare != nil {
                            addressString = addressString + pm.subThoroughfare!
                        }

                        self.adressStr = addressString
                  }
            })

        }
    
//    func sendLocation(_ timeInterval: Double, repeats: Bool) {
//        timer.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
//    }
    
//    @objc func timerAction() {
//        print(Date.now.description)
//        AppStorage.getLoginContext() { responce in
//            switch responce {
//            case .success(let data):
//                if data.role == "principle" {
//                    if data.sendLocation {
//                        self.sendCurrentLocation()
//                    }
//                }
//            case .failure(let error):
//                self.sendCurrentLocation()
//            }
//        }
//    }
    
//    func sendCurrentLocation() {
//        if let location = locationManager.location {
//            self.location = location
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            AuthService.shared.putLocation(latitude: lat, longitude: lon) { [weak self] responce in
//                switch responce {
//                case .success(let data):
//                    print(data)
//                case .failure(let error):
//                    print(error)
//                }
//            }
//        }
//    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("status\(status)")
        checkLocationAuthorization()
    }
}
