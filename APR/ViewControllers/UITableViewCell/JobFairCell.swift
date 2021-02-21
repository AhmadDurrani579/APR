//
//  JobFairCell.swift
//  APR
//
//  Created by Ahmed Durrani on 03/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class JobFairCell: UITableViewCell {
    
    @IBOutlet weak var imgOfJob: UIImageView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
    func setCellData(obj : JobFairList ) {
        lblTime.text = WAShareHelper.getFormattedDateSpecific(string: obj.start_date!)
        lblDescription.text = obj.job_title
        lblLocation.text    = obj.companyLocation
        guard let imgeOfCompany = obj.job_picture  else {
            return
        }
        imgOfJob.setImage(with: imgeOfCompany, placeholder: UIImage(named: "jobFair"))
    }

    
}
