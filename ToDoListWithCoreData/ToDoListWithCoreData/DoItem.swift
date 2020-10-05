//
//  DoItem.swift
//  ToDoListWithCoreData
//
//  Created by Hanlin Chen on 10/5/20.
//

import CoreData


public class Item:NSManagedObject, Identifiable{
    @NSManaged var date:Date?
    @NSManaged var title:String?
}


extension Item {
    static func getAllItems()-> NSFetchRequest<Item>{
        let request:NSFetchRequest<Item> = Item.fetchRequest() as! NSFetchRequest<Item>
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        
        return request
    }
}
