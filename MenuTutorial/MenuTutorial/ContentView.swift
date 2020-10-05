//
//  ContentView.swift
//  MenuTutorial
//
//  Created by Hanlin Chen on 10/5/20.
//

import SwiftUI

struct ContentView: View {
    @State var color = Color.red
    @State var fontSize = 10
    var body: some View {
        VStack{
            
            Text("Hello, world!").foregroundColor(.white).font(.system(size: CGFloat(fontSize))).padding().background(self.color)
            
            Menu(content: {
                Menu("Change Color", content: {
                    Button(action: {
                        self.color = .red
                    }, label: {
                        Text("Red")
                    })
                    
                    Button(action: {
                        self.color = .blue
                    }, label: {
                        Text("Blue")
                    })
                    Button(action: {
                        self.color = .black
                    }, label: {
                        Text("Black")
                    })
                })
                Divider()
                Button(action: {
                        self.fontSize = 20
                    }, label: {
                        Text("FontSize 20")
                    })
                Button(action: {
                        self.fontSize = 25
                    }, label: {
                        Text("FontSize 25")
                    })
                Button(action: {
                        self.fontSize = 30
                    }, label: {
                        Text("FontSize 30")
                    })
        
            }, label: {
                Text("Change Color")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
