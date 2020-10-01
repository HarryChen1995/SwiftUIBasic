//
//  CustomPlaceMarker.swift
//  MapKitBasic
//
//  Created by Hanlin Chen on 10/1/20.
//


import SwiftUI


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}




struct CustomPlaceMarker: View {
    var name:String
    var body: some View{
        ZStack{
            VStack(alignment: .center, spacing:0){
                Text(name).foregroundColor(.white).padding().background(Color.blue).cornerRadius(10)
                Triangle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 20)
            }.padding(10)
        }
    }
}


struct CustomPlaceMarker_Previews: PreviewProvider {
    static var previews: some View {
        CustomPlaceMarker(name: "KFC")
    }
}
