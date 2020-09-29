//
//  NetworkLoader.swift
//  Netflix_UI
//
//  Created by Hanlin Chen on 9/29/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI

class JSonLoader: ObservableObject {
    @Published var categories:[Categ] = [
        Categ(name: "loading", images: [])
    ]
    
    init(){
        let url = URL(string: "http://localhost:1000/categories")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, err) in
            if err != nil {
                print(err!)
            }
            
            DispatchQueue.main.async {
                self.categories = try! JSONDecoder().decode([Categ].self, from: data!)
            }
        }).resume()
    }
    
}
class ImageLoader: ObservableObject {
    @Published var data = Data(UIImage(named: "netflix_logo")!.pngData()!)
    init(image: String){
        let url = URL(string: "http://localhost:1000/images/\(image)")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, err) in
            if err != nil {
                print(err!)
            }
            DispatchQueue.main.async {
                self.data = data!
            }
        }).resume()
    }
}
