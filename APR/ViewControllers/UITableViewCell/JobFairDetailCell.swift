//
//  JobFairDetailCell.swift
//  APR
//
//  Created by Ahmed Durrani on 06/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class JobFairDetailCell: UITableViewCell {

    @IBOutlet weak var imgOfJob: UIImageView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var imgOfCompany: UIImageView!
    @IBOutlet weak var lblCompanyName: UILabel!

    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblStartTimeAndEndTime: UILabel!
    
    @IBOutlet weak var lblAddressTitle: UILabel!
    
    @IBOutlet weak var lblAddressSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : JobFairList) {
        lblJobTitle.text = obj.job_title
        lblCompanyName.text = obj.company_name
        lblDate.text = getFormattedDate(string: obj.start_date!)
        let startTime = obj.start_time
        let endTime = obj.end_time
        lblStartTimeAndEndTime.text = "\(startTime!) - \(endTime!)"
        lblAddressTitle.text = obj.companyLocation
        lblAddressSubTitle.text = obj.address
        guard  let jobImage = obj.job_picture  else   {
            return
        }
        WAShareHelper.loadImage(urlstring:jobImage , imageView: (imgOfJob!), placeHolder: "profile")
        
        guard  let companyImage = obj.company_image  else   {
            return
        }
        WAShareHelper.loadImage(urlstring:companyImage , imageView: (imgOfCompany), placeHolder: "profile")
        let cgFloat: CGFloat = imgOfCompany.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(imgOfCompany, radius: CGFloat(someFloat))

    }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }

}
