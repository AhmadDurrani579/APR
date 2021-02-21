//
//  APEducationCell.swift
//  APR
//
//  Created by Ahmed Durrani on 15/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

protocol SaveEducationInfoDelegate : class {
    func saveEducationInfo(cell : APEducationCell , index : IndexPath)
    func selectStartDate(cell : APEducationCell , index : IndexPath)
    func selectEndDate(cell : APEducationCell , index : IndexPath)
    
}

class APEducationCell: UITableViewCell {
    
    @IBOutlet weak var txtSchool: UITextField!
    @IBOutlet weak var txtDegree: UITextField!
    @IBOutlet weak var txtFieldOfStudy: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!

    @IBOutlet weak var lblCurrentRole: UILabel!
    
    @IBOutlet weak var btnToggle: UIButton!
    weak var delegate : SaveEducationInfoDelegate?
    var indexSelect : IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnStartDate_Pressed(_ sender: UIButton) {
        delegate?.selectStartDate(cell: self, index: indexSelect!)
    }
    @IBAction func btnEndDate_Pressed(_ sender: UIButton) {
        delegate?.selectEndDate(cell: self, index: indexSelect!)

    }
    @IBAction func btnSave_Pressed(_ sender: UIButton) {
        delegate?.saveEducationInfo(cell: self, index: indexSelect!)

    }
    
    @IBAction func btnToggle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
    }
    
    func isEmpty() -> Bool {
        if self.txtSchool.text!.isEmpty || self.txtDegree.text!.isEmpty || self.txtFieldOfStudy.text!.isEmpty || self.txtDescription.text!.isEmpty || btnStartDate.titleLabel?.text == "Start Date" || btnEndDate.titleLabel?.text == "End Date" {
            return true
        }
        return false
    }
}
