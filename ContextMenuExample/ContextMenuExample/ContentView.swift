//
//  ContentView.swift
//  ContextMenuExample
//
//  Created by Hanlin Chen on 10/5/20.
//

import SwiftUI

struct ContentView: View {
    @State var imagenName = "timcook"
    @State var cornerRadius = 20
    var body: some View {
        GeometryReader {
            g in
            Image(imagenName).resizable().aspectRatio(contentMode: .fit).cornerRadius(CGFloat(self.cornerRadius)).padding(30).contextMenu(
            ContextMenu(menuItems: {
                Button(action: {
                    self.imagenName = "timcook"
                }, label: {
                    Text("Tim Cook")
                    Image(systemName: "applelogo")
                })
                
                Button(action: {
                    self.imagenName = "stevejobs"
                }, label: {
                    Text("Steve Jobs")
                    Image(systemName: "applelogo")
                })
                
                Divider()
                
                Menu("Change Corner Radius", content: {
                    Button(action: {
                        self.cornerRadius = 25
                    }, label: {
                        Text("25")
                    })
                    Button(action: {
                        self.cornerRadius = 30
                    }, label: {
                        Text("30")
                    })
                    Button(action: {
                        self.cornerRadius = 35
                    }, label: {
                        Text("35")
                    })
                    Button(action: {
                        self.cornerRadius = 40
                    }, label: {
                        Text("40")
                    })
                })
            }
            )).offset(y:g.frame(in: .global).midY-100)
        }.background(Color(UIColor.systemGray)).ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
