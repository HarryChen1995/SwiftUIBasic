//
//  ContentView.swift
//  MVVMBasic
//
//  Created by Hanlin Chen on 9/21/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI

struct Course:Identifiable, Decodable {
    let id =  UUID()
    let name: String
}
let apiUrl = "https://api.letsbuildthatapp.com/static/courses.json"
class CoursesViewModel:ObservableObject{
    @Published var messages = "Messages inside  observable object"
    @Published var courses:[Course] = [
        .init(name: "Course 1"),
        .init(name: "Course 2"),
        .init(name: "Course 3")
        
    ]
    func changeMessage(){
        self.messages = "changed"
    }
    
    func fetchCourses(){
        // fetch json decode and update some array property
        guard  let url = URL(string: apiUrl) else {
            return
        }
        URLSession.shared.dataTask(with: url){
            (data, response, err) in
            DispatchQueue.main.async {
                self.courses =  try! JSONDecoder().decode([Course].self, from: data!)
            }
        }.resume()
    }
}

struct ContentView: View {
    @ObservedObject var couresesVM = CoursesViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(couresesVM.courses){
                    course in
                    Text(course.name)
                    
                }
            }.navigationBarTitle("Course")
                .navigationBarItems(trailing: Button(action: {
                    self.couresesVM.fetchCourses()
                }){
                    Text("Fetch Course")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
