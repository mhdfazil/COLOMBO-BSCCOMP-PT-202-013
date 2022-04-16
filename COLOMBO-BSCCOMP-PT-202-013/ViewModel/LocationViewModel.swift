//
//  LocationViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var userLocation: CLLocation?
    var locationManager: CLLocationManager?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            return
        }
        DispatchQueue.main.async {
            self.userLocation = currentLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func checkLocationPerission() {
        if let locationManager = locationManager {
            // Get the current location permissions
            let status = CLLocationManager.authorizationStatus()

            // Handle each case of location permissions
            switch status {
                case .authorizedAlways:
                    print("Authorized")
                    break
                case .authorizedWhenInUse:
                    print("Authorized when use")
                    break
                case .denied:
                    print("denied")
                    break
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                    break
                case .restricted:
                    print("Restricted")
                    break
            @unknown default:
                break
            }
        } else {
            return
        }
    }
    
    func checkLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.startUpdatingLocation()
            print("Location Not Available")
        } else {
            print("Location Not Available")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationPerission()
    }
    
}
