//
//  ContentView.swift
//  StateManagementBinding
//
//  Created by Hanlin Chen on 9/21/20.
//  Copyright © 2020 Hanlin Chen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var firstName = ""
    @State var lastName = ""
    @State var users = [String]()
    var body: some View {
        NavigationView{
            VStack {
                VStack{
                    
                    VStack {
                        Group{
                            TextField("First Name", text: $firstName).padding(12)
                            }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 5)).shadow(radius: 5)
                        
                        Group{
                            TextField("LastName Name", text: $lastName).padding(12)
                        }.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 5)).shadow(radius: 5)
                        
                        Button(action: {
                            self.users.append(self.firstName + " " + self.lastName)
                        }){
                            Group{
                                Text("Create User").foregroundColor(.white).padding(12)
                            }.background((firstName.count + lastName.count) > 0 ? Color.blue : Color.gray).clipShape(RoundedRectangle(cornerRadius: 5))
                            
                        }
                    }.padding(12)
                }.background(Color.gray)
                
                List(users, id: \.self){
                    user in
                    Text(user)
                }
                }.navigationBarTitle(Text("Credit Card Form")).navigationBarItems(leading:
                    HStack{
                        Text(firstName)
                        Text(lastName)
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
