//
//  EditExerciseViewController.swift
//  Gym Journal
//
//  Created by Chris Darc on 2016-04-17.
//  Copyright © 2016 Chris Darc. All rights reserved.
//

import UIKit

class EditExerciseViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    //Input Outlets and other useful stuff-----------------------
    
    //exerciseInput
    @IBOutlet weak var exerciseInputText: UILabel!
    
    //weightInput
    @IBOutlet weak var weightInputUnitChooser: UISegmentedControl!
    @IBOutlet weak var weightInputText: UITextField!
    
    //repsInput
    @IBOutlet weak var repsInputPicker: UIPickerView!
    var repsInputPickerResult = 1
    
    //dateInput
    @IBOutlet weak var dateInputPicker: UIDatePicker!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Edit Exercise"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(self.saveChanges))
        //self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //repsInputPicker - setup------------------------------------
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        //plus 1 so that picker view starts at 1 and goes to 100
        return String(row+1)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        repsInputPickerResult = row+1
        //testing
        NSLog("repsInputPickerResult: " + String(repsInputPickerResult))
    }
    
    
    func saveChanges()
    {
        NSLog("Save Pressed")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
