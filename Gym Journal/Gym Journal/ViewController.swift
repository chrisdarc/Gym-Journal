//
//  ViewController.swift
//  Gym Journal
//
//  Created by Chris Darc on 2016-03-25.
//  Copyright © 2016 Chris Darc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddExerciseViewControllerDelegate
{
    //Array to store all exercises.
    //could use [AnyObject]
    var arrayOfExercises: NSMutableArray = []
    
    //dictionary to store items
    var exerciseDetails:[String:String] = [:]
    
    //table view
    @IBOutlet
    var exerciseTable: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //-----------------------
        
        //load the exercises
        self.loadExercises()
        
        //Add edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        //Add plus button - decided to do this with a storyboard and segue instead
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(ViewController.addPersonalRecord))
    }
    
    
    func saveExercises()
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(arrayOfExercises, forKey: "tableViewExercises")
        userDefaults.synchronize()
    }
    
    func loadExercises()
    {
        //load the saved exercises
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let storedArray = userDefaults.objectForKey("tableViewExercises")
        {
            if(storedArray.count == 0)
            {
                //initialize data structure that holds exercises
                arrayOfExercises = [];
            }
                
            else
            {
                //need to make sure that the arrayOfExercises is mutable, found two ways to do this, I like the second. Simpler. First way left here just in case.
                //            let selectedIndices = NSMutableIndexSet(indexesInRange: NSRange(0...storedArray!.count-1))
                //            //make search terms equal to the array that was stored
                //            arrayOfExercises.insertObjects(storedArray as! [AnyObject], atIndexes: selectedIndices)
                
                arrayOfExercises = (storedArray.mutableCopy()) as! NSMutableArray
                
            }
        }
    }
    
    func addInputtedExerciseAttribute(sender: AddExerciseViewController, exerciseKey: String, exerciseValue: String)
    {
        NSLog("Added to dictionary")
        exerciseDetails[exerciseKey] = exerciseValue
    }
    
    
    func saveInputtedExerciseAttribute(sender: AddExerciseViewController)
    {
        NSLog("Save");
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(exerciseDetails, forKey: "currentInputtedExercise")
        userDefaults.synchronize()
        
        //print for testing
        NSLog("Exercise Details: ")
        NSLog(exerciseDetails["exerciseName"]!)
        NSLog(exerciseDetails["weightUnits"]!)
        NSLog(exerciseDetails["weightAmount"]!)
        NSLog(exerciseDetails["repsNumber"]!)
        NSLog(exerciseDetails["dateRecorded"]!)
    }
    
    
    func loadInputtedExerciseAttribute()
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let storedDictionary = userDefaults.objectForKey("currentInputtedExercise")
        {
            if(storedDictionary.count == 0)
            {
                //initialize data structure that holds exercise details
                exerciseDetails = [:];
            }
                
            else
            {
                exerciseDetails = storedDictionary.mutableCopy() as! [String : String]
            }
        }
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
            
            let exercise = inputTextField!.text
            
            var nestedArray: [String] = []
            
            nestedArray.insert(exercise!, atIndex: 0)
            nestedArray.insert("195lbs for 1 rep", atIndex: 1)
            
            //usually would check for nil here, wasn't working in swift for some reason
            
            self.arrayOfExercises.insertObject(nestedArray, atIndex: 0)
                        
            //save array
            self.saveExercises()
            
            //work with table here
            
            //Both 0 because adding to the top of the table
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            
            //Add to table
            self.exerciseTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }))
        
        //add text field
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Exercise"
            inputTextField = textField;
        })
        
        //present the controller
        presentViewController(alert, animated: true, completion: nil);
        
        
    }
    
    //---------------------------------------------
    //Table View Stuff
    
    //setEditing
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        exerciseTable.setEditing(editing, animated: animated)
    }
    
    //number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    //table view number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfExercises.count
    }
    
    //table view cell for row at index path
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cellIdentifier = "Cell"
        
        var cellToReturn = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        if(cellToReturn == nil)
        {
            cellToReturn = UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        }
        
        
        //Customize cell here
        
        
        //call a get content function and put content here
        let tempArray = self.arrayOfExercises[indexPath.row] as! [String]
        
        cellToReturn?.textLabel?.text = tempArray[0]
        cellToReturn?.detailTextLabel?.text = tempArray[1]
        
        return cellToReturn!
    }
    
    
    //did select row at index path
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        NSLog("Cell at row number: \(indexPath.row)")
    }
    
    //table view can edit row at index path
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true;
    }
    
    //table view commit editing style/swipe to delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            //remove from array
            arrayOfExercises.removeObjectAtIndex(indexPath.row)//removeAtIndex(indexPath.row)
            
            //save array
            self.saveExercises()
            
            //remove from table view
            exerciseTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    //can move cell
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        //for now leave this as false, maybe moving can be done later
        return false;
    }
    
    //Looks like this is not required when using a storyboard with swift
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if(segue.identifier == "toExerciseInput")
        {
            NSLog("Reached1")
            let nav = segue.destinationViewController as! UINavigationController
            let addExerciseViewController = nav.topViewController as! AddExerciseViewController
            NSLog("Reached2")
            addExerciseViewController.delegate = self
        }
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

