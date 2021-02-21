//
//  UserProfileCell.swift
//  APR
//
//  Created by Ahmed Durrani on 02/06/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import TagListView

class UserProfileCell: UITableViewCell {
        @IBOutlet weak var lblJobTitle: UILabel!
        @IBOutlet weak var lblCompanyName: UILabel!
        @IBOutlet weak var lblDate: UILabel!
        @IBOutlet weak var lblUniName: UILabel!
        
        @IBOutlet weak var lblDateFinish: UILabel!
        
        @IBOutlet weak var lblDegreeProgram: UILabel!
        
        @IBOutlet weak var tagList: TagListView!
        @IBOutlet weak var skillTagList: TagListView!

    //    @IBOutlet weak var imgOfUser: UIImageView!
        @IBOutlet weak var imgOfCompany: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}