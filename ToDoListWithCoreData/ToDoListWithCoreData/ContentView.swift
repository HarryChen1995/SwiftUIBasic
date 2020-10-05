//
//  ContentView.swift
//  ToDoListWithCoreData
//
//  Created by Hanlin Chen on 10/5/20.
//

import SwiftUI
struct ContentView: View {
    @State var text = ""
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Item.getAllItems()) var doItems: FetchedResults<Item>
    var formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a  MMM d YYYY"
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Insert Item"), content: {
                    HStack{
                        TextField("Create an item", text: $text).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                        
                        
                        Button(action: {
                            let doItem = Item(context: managedObjectContext)
                            doItem.title =  self.text
                            doItem.date = Date()
                            do {
                                try managedObjectContext.save()
                            }catch{
                                print("\(error)")
                            }
                            self.text = ""
                        }, label: {
                            Image(systemName: "plus.circle.fill").foregroundColor(Color.green)
                        })
                    }
                })
                
                Section(header: Text("To Do List"), content: {
                    ForEach(doItems, id: \.date){
                        item in
                        VStack(alignment:.leading){
                            Text("\(item.title!)").font(.headline)
                            Text(formatter.string(from: item.date!)).font(.subheadline)
                        }
                    }.onDelete(perform: { indexSet in
                        let deleItem = self.doItems[indexSet.first!]
                        self.managedObjectContext.delete(deleItem)
                        do {
                            try managedObjectContext.save()
                        }catch{
                            print("\(error)")
                        }
                    })
                })
            }
            .navigationTitle("To Do List").navigationBarItems(trailing: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
