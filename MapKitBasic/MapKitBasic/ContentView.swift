//
//  ContentView.swift
//  MapKitBasic
//
//  Created by Hanlin Chen on 9/30/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var locationMananger = LocationMananger()
    @State var text:String = ""
    var body: some View {
        NavigationView{
            ZStack(alignment:.top){
                Map(coordinateRegion: $locationMananger.reigion, annotationItems: locationMananger.matchingItems , annotationContent: {place in
                    MapAnnotation(coordinate: place.coordinate, content: {
                        CustomPlaceMarker(name: place.name).animation(.default)
                        
                    })
                }).ignoresSafeArea(.all)
                SearchBar(text: $text, locationManager: locationMananger).padding()
            }.navigationTitle("").navigationBarHidden(true)
        }
    }
}


struct SearchBar:View{
    @Binding var text:String
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
            }.background(Color(UIColor.systemGray)).cornerRadius(10)
            .onChange(of: text, perform: { text in
                if text == ""{
                    locationManager.matchingItems.removeAll()
                }else{
                    locationManager.searchPlace(text: text)
                }
                
            })
            .gesture(
                
                TapGesture().onEnded(
                    {
                        self.isEditing = true
                    }
                )
                
            )
            if isEditing {
                Button(action: {
                    UIApplication.shared.closeKeyboar()
                    self.isEditing = false
                    self.text = ""
                }){
                    Text("Cancel").foregroundColor(Color(UIColor.systemGray)).fontWeight(.bold)
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
