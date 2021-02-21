//
//  ExperienceInfoCell.swift
//  APR
//
//  Created by Ahmed Durrani on 09/03/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class ExperienceInfoCell: UITableViewCell {
    @IBOutlet weak var imgOfJob: UIImageView!
    @IBOutlet weak var lblExperience: UILabel!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setExperience(obj : ExperienceOfUser) {
        lblCompanyName.text = obj.company
        lblDesignation.text = obj.title
        lblLocation.text = obj.location

        let start_date = obj.start_date
        let end_date = obj.end_date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: start_date!)
        let enddate = dateFormatter.date(from: end_date!)

        dateFormatter.dateFormat = "MMMM yyyy"
        let startDate = dateFormatter.string(from: date!)
        let endDate = dateFormatter.string(from: enddate!)

        lblExperience.text = "\(startDate) - \(endDate)"

    }
}
