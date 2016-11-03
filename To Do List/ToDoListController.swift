//
//  ToDoListController.swift
//  To Do List
//
//  Created by Geemakun Storey on 2016-09-14.
//  Copyright © 2016 geemakunstorey@storeyofgee.com. All rights reserved.
//

import UIKit
import CoreData

class ToDoListController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: self.tableView)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGrayColor()
        tableView.dataSource = dataSource

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showItem" {
            guard let destinationController = segue.destinationViewController as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            
            let item = dataSource.objectAtIndexPath(indexPath) as! Item
            destinationController.item = item
        }
    }
    
    

    
    // MARK: UITableViewDelevgate
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }
    
    
    
    
    
    
    
    
    
}
