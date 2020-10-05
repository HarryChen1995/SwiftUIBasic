//
//  SlideMenu.swift
//  SlideMenu
//
//  Created by Hanlin Chen on 10/5/20.
//

import SwiftUI

struct SlideMenu: View {
    @Binding var showSlideMenu:Bool
    @Binding var index:Int
    var texts = ["Home", "Profile", "Contact", "Cancel"]
    var body: some View {
        VStack(alignment:.leading, spacing:30){
            Image("stevejobs").resizable().aspectRatio(contentMode: .fill).clipShape(Circle()).frame(width: 100, height: 100)
                .overlay(
                    Circle().stroke(Color(UIColor.systemGray), lineWidth: 5)
                ).shadow(radius: 20)
            Text("Steve Jobs").font(.title).fontWeight(.bold)
            
            VStack(alignment:.leading){
                ForEach(texts, id:\.self){
                    text in
                        Text(text).onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.88, blendDuration: 1)){
                            self.showSlideMenu.toggle()
                            }
                            if text != "Cancel"{
                            self.index = texts.firstIndex(of:text)!
                            }
                        }
                    Divider()
                }
            }
                Spacer()
        }.padding()
    }
}
