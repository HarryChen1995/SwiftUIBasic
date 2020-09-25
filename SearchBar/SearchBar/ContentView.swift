//
//  ContentView.swift
//  SearchBar
//
//  Created by Hanlin Chen on 9/24/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var text:String = ""
    var nums:[Int] = Array(0...100)
    var body: some View {
        NavigationView{
        VStack{
        SearchBarView(text: $text)
            List{
                ForEach(nums.filter({"\($0)".contains(text) || text == ""}), id: \.self){
                    Text("\($0)")
                }
            }
            }.navigationBarTitle(Text("Search"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SearchBarView:View{
    @Binding var text:String
    @State var isEditing = false
    var body: some View{
        HStack{
            TextField("Search ...", text: $text)
            .padding(7)
            .padding(.horizontal, 25)
                .background(Color(.systemGray6))
            .cornerRadius(5)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
             
                    if isEditing {
                        Button(action: {
                            self.text = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        }
                    }
                }
            )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
            }
        }
    }
}
