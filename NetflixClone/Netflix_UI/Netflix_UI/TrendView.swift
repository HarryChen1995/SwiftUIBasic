//
//  DetailView.swift
//  Netflix_UI
//
//  Created by Hanlin Chen on 9/29/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI

struct TrendView: View {
    @ObservedObject var imageLoader:ImageLoader
    init(image:String){
        imageLoader = ImageLoader(image: image)
    }
    var body: some View {
        Image(uiImage: UIImage(data: imageLoader.data)!).resizable().aspectRatio(contentMode: .fit).overlay(
            Button(action:{}){
                Image(systemName: "play.circle").resizable().frame(width:40, height: 40).foregroundColor(.red).padding()
            },
            alignment: .bottomTrailing
            ).overlay(
                VStack(alignment: .leading){
                    Text("Avenger Endgame").font(.system(size: 20)).fontWeight(.bold)
                    HStack{
                    Text("Marvel Studio Movie").font(.subheadline).fontWeight(.bold)
                        Text("90% Match").font(.subheadline).fontWeight(.bold).foregroundColor(.green)
                    }
                }.padding().foregroundColor(.white)
                , alignment:.bottomLeading
            )
    }
}

struct TrendView_Previews: PreviewProvider {
    static var previews: some View {
        TrendView(image:"endgame.jpg")
    }
}
