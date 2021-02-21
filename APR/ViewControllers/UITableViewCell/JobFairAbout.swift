//
//  JobFairAbout.swift
//  APR
//
//  Created by Ahmed Durrani on 06/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class JobFairAbout: UITableViewCell {

    @IBOutlet weak var lblAbout: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : JobFairList) {
        lblAbout.text = obj.descriptionOfJob

    }

    
}
