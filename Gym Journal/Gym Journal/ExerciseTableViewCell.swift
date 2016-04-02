//
//  ExerciseTableViewCell.swift
//  Gym Journal
//
//  Created by Chris Darc on 2016-04-02.
//  Copyright © 2016 Chris Darc. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var ExerciseNameLabel: UILabel!
    
    @IBOutlet weak var WeightAndRepsLabel: UILabel!
    
    @IBOutlet weak var DateRecordedLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
