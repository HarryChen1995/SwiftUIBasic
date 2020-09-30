//
//  ContentView.swift
//  MapKitBasic
//
//  Created by Hanlin Chen on 9/30/20.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

class LocationManger:NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManger = CLLocationManager()
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3875, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    override init(){
        super.init()
        self.locationManger.delegate = self
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManger.distanceFilter = kCLDistanceFilterNone
        self.locationManger.requestWhenInUseAuthorization()
        self.locationManger.activityType = .automotiveNavigation
        self.locationManger.allowsBackgroundLocationUpdates = true
        self.locationManger.requestWhenInUseAuthorization()
        self.locationManger.startUpdatingLocation()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mylocation = locations.last else{
            return
        }
        print(mylocation)
        self.region = MKCoordinateRegion(center: mylocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

        }
    
    
}




struct ContentView: View {
    @StateObject var mananger = LocationManger()

    var body: some View {
        Map(coordinateRegion: $mananger.region).ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
