//
//  SearchBarView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct SearchBarView: View {
    let names = ["Holly", "Rhonda", "Ted"]
    
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            if #available(iOS 15.0, *) {
                List {
                    ForEach(searchResults, id:\.self){
                        name in
                        NavigationLink(destination: Text(name)){
                            Text(name)
                        }
                    }.searchable(text: $searchText){
                        ForEach(searchResults, id:\.self) {
                            result in
                            Text("Are you looking for \(result) ?").searchCompletion(result)
                        }
                    }
                     .navigationTitle("Contact")
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    var searchResults: [String]{
        if searchText.isEmpty {
            return names
        }
        else {
            return names.filter{$0.contains(searchText)}
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
