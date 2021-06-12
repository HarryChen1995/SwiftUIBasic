//
//  AsyncImageView.swift
//  SwiftUI3Basic
//
//  Created by Hanlin Chen on 6/11/21.
//

import SwiftUI

struct AsyncImageView: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            VStack {
                AsyncImage(url: URL(string: "https://www.hackingwithswift.com/img/paul.png")){
                    image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }.frame(width: 128, height: 128).clipShape((RoundedRectangle(cornerRadius: 25)))
                Text("Helloworld")
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
