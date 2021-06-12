//
//  SwipeActionView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct SwipeActionView: View {
    let friends = ["Antonie", "Bass", "Curt", "Dave", "Erica"]
    @State private var total = 0
    var body: some View {
        NavigationView {
            List {
                if #available(iOS 15.0, *) {
                    
                    ForEach(1..<10){
                        i in
                        Text("\(i)").swipeActions(edge: .leading){
                            Button {
                                total += 1
                            } label: {
                                Label("Add \(i)", systemImage: "plus.circle")
                            }
                        }
                            .swipeActions(edge: .trailing){
                                Button {
                                    total -= 1
                                } label: {
                                    Label("Subtract \(i)", systemImage: "minus.circle")
                                }
                            }
                        }
                    
                    ForEach(friends, id:\.self){
                        friend in
                        Text(friend).swipeActions(allowsFullSwipe:false){
                            Button {
                                print("Muting this conversation")
                            } label: {
                                Label("Mute", systemImage: "bell.slash.fill")
                            }.tint(.indigo)
                            
                            Button(role: .destructive) {
                                print("Deleting this conversation")
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                    }
                    
                    
                    Text("Pepperoni Pizza").swipeActions{
                        Button("Order"){
                            print("Awesome!")
                        }.tint(.green)
                    }
                    Text("Pizza with Pineapple").swipeActions{
                        Button("Burn", role: .destructive){
                            print("right on!")
                        }
                    }
                } else {
                    // Fallback on earlier versions
                }
            
            }.navigationTitle("Swipe Action total \(total)")
        }
    }
}

struct SwipeActionView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeActionView()
    }
}
