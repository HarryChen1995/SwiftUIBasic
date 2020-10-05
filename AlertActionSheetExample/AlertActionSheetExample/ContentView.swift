//
//  ContentView.swift
//  AlertActionSheetExample
//
//  Created by Hanlin Chen on 10/5/20.
//

import SwiftUI

struct ContentView: View {
    @State var showAlert = false
    @State var color = Color.white
    @State var fontSize = 20
    @State var showAction = false
    var body: some View {
        VStack{
            Text("Show Alert Controller").font(.system(size: CGFloat(fontSize))).padding().alert(isPresented: $showAlert, content: {
                Alert(title: Text("Alert Title"), message: Text("Alert Message"), primaryButton: .default(Text("Change Font Size")){
                    withAnimation(.linear){
                        self.fontSize = 35
                    }
                }, secondaryButton: .cancel())
            }).onTapGesture{
                self.showAlert.toggle()
            }
            Text("Show ActionSheet").padding().background(color).actionSheet(isPresented: $showAction, content: {
                ActionSheet(title: Text("Action Title"), message: Text("Action Mesage"), buttons: [
                    
                    .default(Text("Red")){
                        self.color = Color.red
                    },
                    .default(Text("Blue")){
                        self.color = Color.blue
                    },
                    .cancel()
                    
                    
                ])
            }).onTapGesture{
                self.showAction.toggle()
            }.animation(.easeInOut)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
