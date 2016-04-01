//
//  AddExerciseViewController.swift
//  Gym Journal
//
//  Created by Chris Darc on 2016-03-28.
//  Copyright © 2016 Chris Darc. All rights reserved.
//

import UIKit

class AddExerciseViewController: UIViewController {

    //Input Outlets---------------------------------------------
    
    //exerciseInput
    @IBOutlet weak var exerciseInputText: UITextField!
    
    //weightInput
    @IBOutlet weak var weightInputUnitChooser: UISegmentedControl!
    @IBOutlet weak var weightInputText: UITextField!
    
    //repsInput
    @IBOutlet weak var repsInputPicker: UIPickerView!
    
    
    //dateInput
    @IBOutlet weak var dateInputPicker: UIDatePicker!
    
    
    
    //Default functions-----------------------------------------
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    //Get and save input functions------------------------------
    
    @IBAction func exerciseInputNextPressed(sender: AnyObject)
    {
        
    }
    
    
    @IBAction func weightInputNextPressed(sender: AnyObject)
    {
        
    }
    
    
    @IBAction func repsInputNextPressed(sender: AnyObject)
    {
        
    }
    
    
    
    
    //dismiss functions-----------------------------------------
    
    @IBAction func exerciseCancelButtonPressed(sender: AnyObject)
    {
        self.dismissAddExerciseViewController()
    }
    
    //this function also used to store info from date picker.
    @IBAction func dateDoneButtonPressed(sender: AnyObject)
    {
        self.dismissAddExerciseViewController()
    }
    
    func dismissAddExerciseViewController()
    {
        //dismiss view controller
        //delegate work here
        self.dismissViewControllerAnimated(true, completion: nil)
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
