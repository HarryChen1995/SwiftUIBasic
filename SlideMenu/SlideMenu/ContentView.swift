//
//  ContentView.swift
//  SlideMenu
//
//  Created by Hanlin Chen on 10/5/20.
//

import SwiftUI

struct ContentView: View {
    @State var showSlideMenu = false
    @State var index = 0
    var texts = ["Home", "Profile", "Contact"]
    var color = [Color.blue, Color.red, Color.pink]
    var body: some View {
        
        HStack{
            if showSlideMenu {
                SlideMenu(showSlideMenu:$showSlideMenu, index: $index).transition(.move(edge: .leading))
            }
            NavigationView{
                
                TabView(selection: $index){
                    GeometryReader {
                        g in
                        Text(texts[index]).font(.title).fontWeight(.bold).foregroundColor(.white).padding()
                        
                    }.background(color[0]).tabItem {
                        Text(texts[0])
                        Image(systemName: "house")
                    }.tag(0)
                    
                    GeometryReader {
                        g in
                        Text(texts[index]).font(.title).fontWeight(.bold).foregroundColor(.white).padding()
                        
                    }.background(color[1]).tabItem {
                        Text(texts[1])
                        Image(systemName: "person")
                    }.tag(1)
                    
                    
                    GeometryReader {
                        g in
                        Text(texts[index]).font(.title).fontWeight(.bold).foregroundColor(.white).padding()
                        
                    }.background(color[2]).tabItem {
                        Text(texts[2])
                        Image(systemName: "phone")
                    }.tag(2)
                    
                }.accentColor(.red).navigationTitle("").navigationBarItems(leading: Button(action: {
                    
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.88, blendDuration: 1)){
                        self.showSlideMenu.toggle()
                    }
                }, label: {
                    Image(systemName: "line.horizontal.3").foregroundColor(Color(UIColor.systemGray))
                }))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
