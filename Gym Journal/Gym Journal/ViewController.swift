//
//  ViewController.swift
//  Gym Journal
//
//  Created by Chris Darc on 2016-03-25.
//  Copyright © 2016 Chris Darc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //Add plus button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.addPersonalRecord))
        
    }
    
    func addPersonalRecord()
    {
        NSLog("Add new item")
        
        //create the text input field
        var inputTextField: UITextField?
        
        //for now, use alert controller, later use a modal
        //create alert controlelr
        let alert = UIAlertController(title: "Log Exercise", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        //add cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        //add Ok button
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            //Save word in array here
            
            NSLog("Text entered: " + (inputTextField?.text)!)
        }))
        
        //add text field
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Exercise"
            inputTextField = textField;
        })
        
        //present the controller
        presentViewController(alert, animated: true, completion: nil);
        
        
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

