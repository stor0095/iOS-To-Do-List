//
//  CoreDataStack.swift
//  To Do List
//
//  Created by Geemakun Storey on 2016-09-14.
//  Copyright © 2016 geemakunstorey@storeyofgee.com. All rights reserved.
//

import Foundation
import CoreData


public class DataController: NSObject {
    
    // a swift singleton
    static let sharedInstance = DataController()
    
    private override init() {
        
    }
    
    // Store database
    private lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.endIndex.predecessor()]
    }()
    
    // Managed object model. Forced unwrapped so if the file doesn't exist, quit the app.
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("To Do List", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("To Do List.sqlite")
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            let userInfo: [String: AnyObject] = [
                NSLocalizedDescriptionKey: "Failed to initalize application's saved data",
                NSLocalizedFailureReasonErrorKey: "There was an error creating or loading the apps saved data",
                NSUnderlyingErrorKey: error as NSError
            ]
            let wrappedError = NSError(domain: "com.storeyofgee.CoreDataError", code: 9999, userInfo: userInfo)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    public lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }()
    
    public func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                // error handling
                print("Unknown error \(error), \(error.userInfo)")
            }
            
        }
        
    }
    
    
    
}