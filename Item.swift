//
//  Item.swift
//  To Do List
//
//  Created by Geemakun Storey on 2016-09-15.
//  Copyright © 2016 geemakunstorey@storeyofgee.com. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {
    
    static let identifier = "Item"

    static let fetchRequest: NSFetchRequest = {
        
        let request = NSFetchRequest(entityName: Item.identifier)
        let sortDescriptor = NSSortDescriptor(key: "text", ascending: true)
        
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
        
    }()


}
