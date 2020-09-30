//
//  ContentView.swift
//  Netflix_UI
//
//  Created by Hanlin Chen on 9/29/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI


struct Categ: Codable {
    var name:String
    var images:[String]
}


struct ContentView: View {
    var body: some View {
        NavigationView {
            Home().navigationBarTitle("").navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home :  View{
    @ObservedObject var jsonloader = JSonLoader()
    @State var text: String = ""
    var body: some View{
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 15){
                HStack {
                    Image(systemName: "line.horizontal.3").foregroundColor(.white)
                    Image("netflix_logo").resizable().aspectRatio(contentMode: .fit).frame(width:100)
                    Spacer()
                    Button(action:{}){
                        Image(systemName:"person.crop.circle").foregroundColor(.white)
                    }
                }
                SearchBar(text: $text)
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(self.jsonloader.categories.filter({
                        $0.name.contains(text.trimmingCharacters(in: CharacterSet.whitespaces)) || text == ""
                    }), id:\.name){
                        category in
                        VStack(alignment: .leading, spacing:10){
                            Text(category.name).font(.headline).foregroundColor(.white)
                            if category.name == "Trending" {
                                TrendView(image: category.images[0])
                            }
                            else {
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing: 10){
                                        ForEach(category.images, id:\.self){
                                            ImageView(image: $0)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }.padding(.leading, 15).padding(.trailing, 15)
        }
    }
}


struct SearchBar:View{
    @Binding var text:String
    @State var isEditing = false
    var body: some View {
        HStack{
            HStack{
                Image(systemName: "magnifyingglass").padding(.leading, 10)
                ZStack(alignment: .leading){
                    if text.isEmpty {
                        Text("Search Category")
                    }
                    TextField("", text: $text)
                }.padding()
                Button(action:{
                    self.text = ""
                }){
                    Image(systemName: "xmark.circle.fill")
                }.padding(.trailing, 10)
                }.background(Color(UIColor(named: "searchbarcolor")!)).cornerRadius(10).gesture(
                    
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
                    Text("Cancel")
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
