//
//  NewTabView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct NewTabView: View {
    var body: some View {
        TabView {
            if #available(iOS 15.0, *) {
                Text("your home screen goes here").tabItem{
                    Label("Home", systemImage: "house")
                }.badge(5)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

struct NewTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewTabView()
    }
}
