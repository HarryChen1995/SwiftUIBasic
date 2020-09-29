//
//  ImageView.swift
//  Netflix_UI
//
//  Created by Hanlin Chen on 9/29/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI


struct ImageView: View{
    @ObservedObject var imageloader:ImageLoader
    init(image:String){
        imageloader = ImageLoader(image: image)
    }
    
    var body: some View {
           
        Image(uiImage: UIImage(data: imageloader.data)!).resizable().frame(width:100, height: 150)

    }
    
}
