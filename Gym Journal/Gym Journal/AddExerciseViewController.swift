//
//  AddExerciseViewController.swift
//  Gym Journal
//
//  Created by Chris Darc on 2016-03-28.
//  Copyright © 2016 Chris Darc. All rights reserved.
//

import UIKit

//delegate to ViewController stuff
protocol AddExerciseViewControllerDelegate: class
{
    func addInputtedExerciseAttribute(sender: AddExerciseViewController, exerciseKey: String, exerciseValue: String)
    
    func addPersonalRecord(sender: AddExerciseViewController)
}

class AddExerciseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate:AddExerciseViewControllerDelegate?
    
    
    
    //Input Outlets and other useful stuff-----------------------
    
    //exerciseInput
    @IBOutlet weak var exerciseInputText: UITextField!
    
    //weightInput
    @IBOutlet weak var weightInputUnitChooser: UISegmentedControl!
    @IBOutlet weak var weightInputText: UITextField!
    
    //repsInput
    @IBOutlet weak var repsInputPicker: UIPickerView!
    var repsInputPickerResult = 1
    
    //dateInput
    @IBOutlet weak var dateInputPicker: UIDatePicker!
    
    
    //Default functions-----------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        if (self.restorationIdentifier == "WeightInputRestoreID")
        {
            //make the keyboard for the weight input a number pad
            weightInputText.keyboardType = UIKeyboardType.DecimalPad
            //create the done button
            let keyboardDoneButtonView = UIToolbar.init()
            keyboardDoneButtonView.sizeToFit()
            //adding this flex button makes the done button appear on the right.  The flex button does nothing.
            let flexBarButton = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: nil, action: #selector(self.keyboardDonePressed))
            keyboardDoneButtonView.items = [flexBarButton, doneButton]
            //keyboardDoneButtonView.setItems(NSArray(objects: doneButton) as? [UIBarButtonItem], animated: true)
            weightInputText.inputAccessoryView = keyboardDoneButtonView
        }
    }
    
    func keyboardDonePressed()
    {
        NSLog("Keyboard Done Pressed")
        self.view.endEditing(true)
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
    
    
    //dismiss functions-----------------------------------------
    
    @IBAction func exerciseCancelButtonPressed(sender: AnyObject)
    {
        self.dismissAddExerciseViewController()
    }
    
    //this function also used to store info from date picker.
    @IBAction func dateDoneButtonPressed(sender: AnyObject)
    {
        let dateFormatter = NSDateFormatter()
        //dateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.dateStyle = .FullStyle
        let dateString = dateFormatter.stringFromDate(dateInputPicker.date)
        
        delegate?.addInputtedExerciseAttribute(self, exerciseKey: "dateRecorded", exerciseValue: dateString)
        
        delegate?.addPersonalRecord(self)
        
        self.dismissAddExerciseViewController()
    }
    
    func dismissAddExerciseViewController()
    {
        //dismiss view controller
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        //save all values entered here before segues, put them in a dictionary in the ViewController class.
        if(segue.identifier == "toWeightInput")
        {
            delegate?.addInputtedExerciseAttribute(self, exerciseKey: "exerciseName", exerciseValue: exerciseInputText.text!)
            
            let toWeight = segue.destinationViewController as! AddExerciseViewController
            toWeight.delegate = self.delegate
            
        }
        else if(segue.identifier == "toRepsInput")
        {
            delegate?.addInputtedExerciseAttribute(self, exerciseKey: "weightUnits", exerciseValue: weightInputUnitChooser.titleForSegmentAtIndex(weightInputUnitChooser.selectedSegmentIndex)!)
                
            delegate?.addInputtedExerciseAttribute(self, exerciseKey: "weightAmount", exerciseValue: weightInputText.text!)
            
            let toDate = segue.destinationViewController as! AddExerciseViewController
            toDate.delegate = self.delegate
        }
        else if(segue.identifier == "toDateInput")
        {
            delegate?.addInputtedExerciseAttribute(self, exerciseKey: "repsNumber", exerciseValue: String(repsInputPickerResult))
            
            let toDone = segue.destinationViewController as! AddExerciseViewController
            toDone.delegate = self.delegate
        }
    }

}
