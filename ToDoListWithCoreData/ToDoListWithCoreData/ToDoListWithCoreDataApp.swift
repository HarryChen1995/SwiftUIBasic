//
//  ToDoListWithCoreDataApp.swift
//  ToDoListWithCoreData
//
//  Created by Hanlin Chen on 10/5/20.
//

import SwiftUI
import CoreData
@main
struct ToDoListWithCoreDataApp: App {
    var managedObjectContext = { () -> NSManagedObjectContext in
        let container = NSPersistentContainer(name: "DoItemModel")
        container.loadPersistentStores(completionHandler: {
            _, error in
            if error != nil {
                fatalError("\(error!)")
            }
        })
        return container.viewContext
    }()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, managedObjectContext)
        }
    }
}
