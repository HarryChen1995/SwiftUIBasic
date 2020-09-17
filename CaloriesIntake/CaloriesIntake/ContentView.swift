//
//  ContentView.swift
//  CaloriesIntake
//
//  Created by Hanlin Chen on 9/17/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var pickerSelectedItem = 0
    @State var dataPoints:[[CGFloat]] = [
        [50,100,150,30,40],
        [150,100,50,200,10],
        [10,20,30,50,100],
    ]
    var body: some View {
        ZStack{
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            VStack{
                Text("Calories Intakes")
                    .font(.system(size: 34))
                    .fontWeight(.heavy)
                
                Picker(selection: $pickerSelectedItem, label: Text("")){
                    Text("Weekday").tag(0)
                    Text("Afternoon").tag(1)
                    Text("Evenining").tag(2)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal, 24)
                
                HStack(spacing:16){
                    BarView(value:dataPoints[pickerSelectedItem][0])
                    BarView(value:dataPoints[pickerSelectedItem][1])
                    BarView(value: dataPoints[pickerSelectedItem][2])
                    BarView(value: dataPoints[pickerSelectedItem][3])
                    BarView(value: dataPoints[pickerSelectedItem][4])
                    
                }.padding(.top, 24).animation(.default)
            }
            
            
        }
    }
}


struct BarView:View{
    var value: CGFloat
    var body: some View{
        VStack{
            ZStack(alignment: .bottom){
                Capsule().frame(width:30, height:200).foregroundColor(Color(#colorLiteral(red: 0.155872027, green: 0.7813378863, blue: 0.6619333318, alpha: 1)))
                Capsule().frame(width:30, height: value).foregroundColor(.white)
            }
            Text("D").padding(.top, 8)
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
