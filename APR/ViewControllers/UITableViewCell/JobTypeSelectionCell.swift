//
//  JobTypeSelectionCell.swift
//  APR
//
//  Created by Ahmed Durrani on 12/05/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

protocol SelectJobTypeDelegate : class{
    func selectJobType(cell : JobTypeSelectionCell , index : IndexPath)
}
class JobTypeSelectionCell: UITableViewCell {
    @IBOutlet weak var lblJobType: UILabel!
    weak var delegate : SelectJobTypeDelegate?
    var selectIndex : IndexPath?
    @IBOutlet weak var btnJobType: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnJobTypeSelect_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.selectJobType(cell: self, index: selectIndex!)

        
    }
}
