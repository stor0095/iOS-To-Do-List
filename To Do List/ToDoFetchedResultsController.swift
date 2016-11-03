//
//  ToDoFetchedResultsController.swift
//  To Do List
//
//  Created by Geemakun Storey on 2016-09-15.
//  Copyright © 2016 geemakunstorey@storeyofgee.com. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ToDoFetchedResultsController: NSFetchedResultsController, NSFetchedResultsControllerDelegate {
    
    private let tableView: UITableView
    
    init(managedObjectContext: NSManagedObjectContext, withTableView tableView: UITableView) {
        self.tableView = tableView
        super.init(fetchRequest: Item.fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.delegate = self
        
        tryFetch()
    }
    
    func tryFetch() {
        do {
            try performFetch()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    //MARK: NSFetchedResultsControllerDelefate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        tableView.reloadData()
        tableView.endUpdates()
    
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            guard let indexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Update, .Move:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    
}


