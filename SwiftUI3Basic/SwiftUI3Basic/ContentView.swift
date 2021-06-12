//
//  ContentView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            ForegroundStyleView()
        } else {
            Text("Hell World")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
