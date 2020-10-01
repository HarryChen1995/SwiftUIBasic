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
    var address: String
    var coordinate: CLLocationCoordinate2D
}


let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
class LocationMananger:NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager = CLLocationManager()
    @Published var  matchingItems:[Place] = []
    @Published var reigion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3875, longitude: -122.4194), span: span)
    @Published var location = CLLocationCoordinate2D(latitude: 37.3875, longitude: -122.4194)
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
        location = mylocation.coordinate
        reigion =  MKCoordinateRegion(center: mylocation.coordinate, span: span)
        
        
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
    

    func searchPlace(text:String){
        let request =  MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.region = reigion
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: { response,  _ in
            guard let response = response else {
                return
            }
            self.matchingItems = []
            for item in response.mapItems {
                self.matchingItems.append(Place(name: item.placemark.name!, address: item.placemark.title!,coordinate: item.placemark.coordinate))
            }
            print(self.matchingItems)
        })
    }
}
