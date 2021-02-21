//
//  EducationInfoCell.swift
//  APR
//
//  Created by Ahmed Durrani on 09/03/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class EducationInfoCell: UITableViewCell {

    @IBOutlet weak var lblUniTitle: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblUniProgram: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
