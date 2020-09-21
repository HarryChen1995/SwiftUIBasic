//
//  ContentView.swift
//  FetchImageJsonWithBindableObject
//
//  Created by Hanlin Chen on 9/21/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI
import Combine

struct Course:Identifiable, Decodable{
    let id = UUID()
    let name, imageUrl:String
}


class NetworkManager: ObservableObject {
    
    @Published var courses = [Course]()
    
    init(){
        guard  let url = URL(string:"https://api.letsbuildthatapp.com/jsondecodable/courses") else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, _, _) in
            let courses = try! JSONDecoder().decode([Course].self, from: data!)
            DispatchQueue.main.async {
                self.courses = courses
            }
            
        }.resume()
    }
}

struct ContentView: View {
    @ObservedObject var networkManger = NetworkManager()
    var body: some View {
        NavigationView{
            List(networkManger.courses){
               CourseView(course: $0)
            }.navigationBarTitle(Text("Courses"))
        }
    }
}



struct CourseView:View{
    let course:Course
    var body:some View{
        VStack(alignment:.leading){
            ImageView(imageUrl: course.imageUrl)
            Text(course.name)
        }
    }
}

class ImageLoader:ObservableObject {
    @Published var data = Data()
    
    init(urlString:String){
        guard let  url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            (data, _, _ ) in
            DispatchQueue.main.async {
                self.data = data!
            }
        }
        
        task.resume()
    }
    
}
struct ImageView:View{
    @ObservedObject var imageLoader:ImageLoader
    init(imageUrl:String){
        imageLoader = ImageLoader(urlString: imageUrl)
    }
    var body: some View{
        Image(uiImage: (imageLoader.data.count != 0 ?  UIImage(data: imageLoader.data)! : UIImage(systemName: "trash")!)).resizable().frame(width:320, height:200)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
