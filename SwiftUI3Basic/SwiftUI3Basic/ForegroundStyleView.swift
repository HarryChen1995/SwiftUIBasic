//
//  ForegroundStyleView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct ForegroundStyleView: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack {
                HStack{
                    Image(systemName: "clock.fill")
                    Text("Set the time")
                }.font(.largeTitle.bold())
                    .foregroundStyle(.quaternary)
                HStack{
                    Image(systemName: "clock.fill")
                    Text("Set the time")
                }.font(.largeTitle.bold())
                    .foregroundStyle(.linearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom))
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct ForegroundStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ForegroundStyleView()
    }
}
