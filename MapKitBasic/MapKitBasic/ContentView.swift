//
//  ContentView.swift
//  MapKitBasic
//
//  Created by Hanlin Chen on 9/30/20.
//

import SwiftUI
import MapKit
let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
let userSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
let appleSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
let appleCampusCoordinate = CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.03118)
struct ContentView: View {
    @State var text:String = ""
    @StateObject var locationMananger = LocationMananger()
    @State var region =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3875, longitude: -122.4194), span: span)
    var body: some View {
        
        NavigationView{
            ZStack(alignment:.top){
                Map(coordinateRegion: $region,annotationItems: locationMananger.matchingItems , annotationContent: {place in
                    MapAnnotation(coordinate: place.coordinate, content: {
                        CustomPlaceMarker(name: place.name).transition(.slide)
                        
                    })
                }).ignoresSafeArea(.all).overlay(
                
                    VStack{
                    Button(action: {
                        locationMananger.matchingItems = [Place(name: "😎", coordinate: locationMananger.userLocation.coordinate)]
                        region =  MKCoordinateRegion(center: locationMananger.userLocation.coordinate, span: userSpan)
                    }, label: {
                        Image(systemName: "location.fill").foregroundColor(Color(UIColor.systemGray)).padding(20).background(Color.white)
                            .cornerRadius(20).padding().shadow(radius: 10)
                    })
                        
                    Button(action: {
                            locationMananger.matchingItems = [Place(name: "", coordinate: appleCampusCoordinate)]
                            region =  MKCoordinateRegion(center: appleCampusCoordinate, span: appleSpan)
                        }, label: {
                            Image(systemName: "applelogo").foregroundColor(Color(UIColor.systemGray)).padding(20).background(Color.white)
                                .cornerRadius(20).padding().shadow(radius: 10)
                        })
                        
                    },
                    
                    alignment: .trailing
                )
                SearchBar(text: $text,region: $region, locationManager: locationMananger).padding().shadow(radius: 20)
            }.animation(.easeInOut).navigationTitle("").navigationBarHidden(true)
        }
    }
}




struct SearchBar:View{
    @Binding var text:String
    @Binding var region:MKCoordinateRegion
    @State var isEditing = false
    var locationManager:LocationMananger
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass").padding(.leading, 10)
                ZStack(alignment: .leading){
                    if text.isEmpty {
                        Text("Search")
                    }
                    TextField("", text: $text)
                }.padding()
                Button(action:{
                    self.text = ""
                }){
                    Image(systemName: "xmark.circle.fill")
                }.padding(.trailing, 10)
            }.background(Color(UIColor.systemGray)).cornerRadius(20)
            .gesture(
                
                TapGesture().onEnded(
                    {
                        self.isEditing = true
                    }
                )
                
            )
            if isEditing {
                Button(action: {
                    locationManager.searchPlace(text: text, region: region)
                    UIApplication.shared.closeKeyboar()
                    self.isEditing = false
                    self.text = ""
                }){
                    Text("Search").foregroundColor(Color(UIColor.systemGray)).fontWeight(.bold)
                }.transition(.move(edge: .trailing))
            }
        }.foregroundColor(.white).animation(.default)
    }
}


extension UIApplication {
    func closeKeyboar(){
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
