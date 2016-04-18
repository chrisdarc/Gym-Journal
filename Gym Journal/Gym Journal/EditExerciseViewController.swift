//
//  EditExerciseViewController.swift
//  Gym Journal
//
//  Created by Chris Darc on 2016-04-17.
//  Copyright © 2016 Chris Darc. All rights reserved.
//

import UIKit

//delegate to ViewController stuff
protocol EditExerciseViewControllerDelegate: class
{
    //func addInputtedExerciseAttribute(sender: AddExerciseViewController, exerciseKey: String, exerciseValue: String)
    
    //func addPersonalRecord(sender: AddExerciseViewController)
    
    func updatePersonalRecord(sender: EditExerciseViewController, indexToUpdate: Int, dictionaryForUpdate: [String:String])
}

class EditExerciseViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource
{
    
    weak var delegate:EditExerciseViewControllerDelegate?
    
    
    //dictionary to store items
    var exerciseDetails:[String:String] = [:]
    //can have the keys
    //"exerciseName"
    //"weightUnits"
    //"weightAmount"
    //"repsNumber"
    //"dateRecorded"
    
    
    //index of the record being updated
    var indexOfRecord:Int = 0
    
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
        
        //set up all the IBOutlets
        exerciseInputText.text = exerciseDetails["exerciseName"]
        weightInputText.text = exerciseDetails["weightAmount"]
        if(exerciseDetails["weightUnits"] == "lbs")
        {
            weightInputUnitChooser.selectedSegmentIndex = 0
        }
        else
        {
            weightInputUnitChooser.selectedSegmentIndex = 1
        }
        
        repsInputPicker.selectRow(Int(exerciseDetails["repsNumber"]!)!-1, inComponent: 0, animated: true)
        
        let convertToDate = NSDateFormatter()
        convertToDate.dateStyle = .FullStyle
        let dateFromString = convertToDate.dateFromString(exerciseDetails["dateRecorded"]!)
        dateInputPicker.date = dateFromString!
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getExercisesDictionary(dict: [String:String], index: Int)
    {
        exerciseDetails = dict
        indexOfRecord = index
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
        
        //save everything in dictionary
        exerciseDetails["weightUnits"] = weightInputUnitChooser.titleForSegmentAtIndex(weightInputUnitChooser.selectedSegmentIndex)
        exerciseDetails["weightAmount"] = weightInputText.text
        exerciseDetails["repsNumber"] = String(repsInputPickerResult)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        let dateString = dateFormatter.stringFromDate(dateInputPicker.date)
        exerciseDetails["dateRecorded"] = dateString
        
        delegate?.updatePersonalRecord(self, indexToUpdate: indexOfRecord, dictionaryForUpdate: exerciseDetails)
        self.navigationController?.popViewControllerAnimated(true)
        //navigationController!.dismissViewControllerAnimated(true, completion: nil)
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
