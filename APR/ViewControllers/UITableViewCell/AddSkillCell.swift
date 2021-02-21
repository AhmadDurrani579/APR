//
//  AddSkillCell.swift
//  APR
//
//  Created by Ahmed Durrani on 12/05/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
protocol SelectSkillDelegate : class{
    func selectSkill(cell : AddSkillCell , index : IndexPath)
}
class AddSkillCell: UITableViewCell {

    @IBOutlet weak var lblSkill: UILabel!
    weak var delegate : SelectSkillDelegate?
    var selectIndex : IndexPath?
    @IBOutlet weak var btnSelectSkill: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnSkillAdd_Pressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.selectSkill(cell: self, index: selectIndex!)
    }
}
