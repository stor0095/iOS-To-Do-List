//
//  DetailViewController.swift
//  To Do List
//
//  Created by Geemakun Storey on 2016-09-15.
//  Copyright © 2016 geemakunstorey@storeyofgee.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
//    var colourModel = ColourModel()
    
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let randomColour =  colourModel.getRandomColor()
//        view.backgroundColor = randomColour
        view.backgroundColor = UIColor.lightGrayColor()
        labelTitle.text = item?.text
        self.textField.delegate = self
        
//        guard let item = item else {fatalError("Cannot load without an item")}
        self.title = "Edit"
//        textField.text = "Edit Item"
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func save(sender: AnyObject) {
        guard let text = textField.text where !text.isEmpty else { showAlert("Whoops!", message: "Won't save if no edits are made."); return }
        
        if let item = item {
            item.text = textField.text
            DataController.sharedInstance.saveContext()
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        
        return true;
    }
    
    
    
    func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .Alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(dismissAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    

}
