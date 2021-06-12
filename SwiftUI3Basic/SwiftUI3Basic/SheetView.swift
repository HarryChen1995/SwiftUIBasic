//
//  SheetView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct ExampleSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var termsAccepted = false
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack{
                Text("Terms and Conditions").font(.title)
                Text("Lots of legalese here ...")
                Toggle("Accept", isOn: $termsAccepted)
            }.padding().interactiveDismissDisabled(!termsAccepted)
        } else {
            // Fallback on earlier versions
        }
    }
    
    func close(){
        presentationMode.wrappedValue.dismiss()
    }
}

struct SheetView: View {
    @State private var showingSheet = false
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }.sheet(isPresented: $showingSheet, content: ExampleSheet.init)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView()
    }
}
