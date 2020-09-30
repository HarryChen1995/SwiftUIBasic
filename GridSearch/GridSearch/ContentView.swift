//
//  ContentView.swift
//  GridSearch
//
//  Created by Hanlin Chen on 9/30/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        let data = Array(1...100)
        
        let  layout  = [
            GridItem(.flexible(minimum: 100, maximum: 200), spacing: 50),
            GridItem(.flexible(minimum: 100, maximum: 200)),
            GridItem(.flexible(minimum: 100, maximum: 200))
        ]
        ScrollView{
            LazyVGrid(columns: layout,spacing:20,content: {
                ForEach(data, id:\.self){ data in
                    VStack{
                        Capsule().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Text("\(data)").padding()
                    }
                }
            }).padding(.horizontal, 30)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
