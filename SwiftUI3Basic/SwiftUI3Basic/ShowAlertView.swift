//
//  ShowAlertView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct ShowAlertView: View {
    @State private var showingAlert = false
    @State private var showingOptions = false
    @State private var selected  = "None"
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack {
                
                
                Text(selected)
                Button("Confirm paint color") {
                    showingOptions = true
                }.confirmationDialog("Selected a Color", isPresented: $showingOptions){
                    Button("Red", role: .destructive){
                        selected = "red"
                    }
                    Button("Green") {
                        selected = "green"
                    }
                    Button("Blue") {
                        selected = "blue"
                    }
                }
            
                Button("Show Alert") {
                    showingAlert = true
                }.alert("Important Message !", isPresented: $showingAlert) {
                    Button("First", role: .destructive){
                        
                    }
                    Button("Second"){
                        
                    }
                    Button("Third"){
                        
                    }
            }
            
            
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct ShowAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ShowAlertView()
    }
}
