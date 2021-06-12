//
//  MenuView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            Menu("Options") {
                Button("Order now", action:{})
                Button("Cancel", action: {})
            } primaryAction: {
                justDoit()
            }
        } else {
            // Fallback on earlier versions
            Text("Hell World")
        }
        
    }
    
    func justDoit(){
        print("Button was tapped")
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
