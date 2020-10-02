//
//  LocationMananger.swift
//  MapKitBasic
//
//  Created by Hanlin Chen on 10/1/20.
//

import MapKit
import SwiftUI
import Combine

struct Place: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}



class LocationMananger:NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager = CLLocationManager()
    @Published var userLocation: CLLocation = CLLocation(latitude: 37.3875, longitude: -122.4194)
    @Published var  matchingItems:[Place] = []

    override init(){
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.activityType = .automotiveNavigation
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mylocation = locations.first else{
            return
        }
        userLocation = mylocation
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print(error)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways {
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
    }
    

    func searchPlace(text:String, region:MKCoordinateRegion){
        let request =  MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.region = region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { response,  _ in
            guard let response = response else {
                return
            }
            self.matchingItems = []
            for item in response.mapItems {
                self.matchingItems.append(Place(name: item.placemark.name!,coordinate: item.placemark.coordinate))
            }
            print(self.matchingItems)
        })
    }
}
