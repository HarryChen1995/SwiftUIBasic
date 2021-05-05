//
//  ContentView.swift
//  BarCodeScanner
//
//  Created by Hanlin Chen on 5/5/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RecordingView().ignoresSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
