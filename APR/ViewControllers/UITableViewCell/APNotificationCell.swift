//
//  APNotificationCell.swift
//  APR
//
//  Created by Ahmed Durrani on 06/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APNotificationCell: UITableViewCell {

//    @IBOutlet weak var lblNotifyType: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgOfCompany: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : NotificationList ) {
//        lblDate.text = obj.noti_type
//        lblNotifyType.text = obj.senderData?.company_name
        lblDescription.text    = obj.noti_type
        lblDate.text = WAShareHelper.getFormattedDate2(string: obj.date!)

        guard let senderData = obj.senderData else {
            return
        }
        guard let img = senderData.company_image else {
                   return
         }
        WAShareHelper.loadImage(urlstring:img , imageView: imgOfCompany , placeHolder: "images")
        let cgFloat: CGFloat = (imgOfCompany.frame.size.width)/2.0
        let someFloat = Float(cgFloat)
        GeneralUtilities.setViewCornerRadius(imgOfCompany , radius: CGFloat(someFloat))
        
        
    }

}
