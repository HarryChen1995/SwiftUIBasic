//
//  ContentView.swift
//  TextScanner
//
//  Created by Hanlin Chen on 5/8/21.
//

import SwiftUI


struct PressButton : View {
    var body: some View {
        ZStack{
            Circle().strokeBorder(Color.white,lineWidth: 3).frame(width: 60, height: 60)
            Circle().fill(Color.white).frame(width: 50, height: 50)
        }
    }
}

struct ContentView: View {
    @State var isTappped:Bool = false
    @State var uiImage:UIImage = UIImage(named: "SilverCard")!
    @State var showDetectionResult = false
    @State var text = ""
    var body: some View {
        ZStack{
            TectScannerView(delegate: self)
            Button(action: {
                isTappped.toggle()
            }, label: {
                PressButton().background(Color.clear).position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 100)
            }).sheet(isPresented: $showDetectionResult, content: {
                ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false){
                    VStack{
                        HStack{
                            Spacer()
                            Button(action: {
                                showDetectionResult.toggle()
                            }, label: {
                                Text("Cancel")
                            })
                        }.padding()
                        Divider()
                        Image(uiImage: uiImage).resizable().aspectRatio(contentMode: .fit).padding()
                        Text(text).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).padding()
                        Spacer()
                    }
                }
            })
        }.ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
