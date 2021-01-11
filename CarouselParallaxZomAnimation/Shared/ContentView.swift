//
//  ContentView.swift
//  Shared
//
//  Created by Hanlin Chen on 1/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            Home().navigationTitle("").navigationBarHidden(true)
        }
    }
}


struct Home : View {
    private func getScale(proxy:GeometryProxy) -> CGFloat {
        var scale:CGFloat = 1
        let x = proxy.frame(in: .global).minX
        let diff  = abs(x)
        if diff < 100 {
            scale = 1 + (100-diff)/500
        }
        
        return scale
    }
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment:.leading){
                Text("Trending").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).foregroundColor(.white).padding(.horizontal)
                ScrollView {
                    ScrollView(.horizontal , showsIndicators: false){
                        HStack(spacing:20){
                            ForEach(1..<20){
                                num in
                                GeometryReader {
                                    proxy in
                                    
                                    VStack{
                                        let scale = getScale(proxy: proxy)
                                        
                                        Image("queengambit").resizable().scaledToFit()
                                            .cornerRadius(10)
                                            .shadow(color: Color.white, radius: 5 )
                                            .scaleEffect(CGSize(width: scale, height: scale))
                                        Text("Queen's Gambit").foregroundColor(.white).fontWeight(.bold).padding(.top).multilineTextAlignment(.center)
                                    }
                                }
                                .frame(width:170, height:300)
                                
                            }
                        }.padding(32)
                    }.animation(.easeInOut)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
