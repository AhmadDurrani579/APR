//
//  ProfileCell.swift
//  APR
//
//  Created by Ahmed Durrani on 22/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import TagListView

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var lblUserNam: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblNumberOfExperience: UILabel!
    
    @IBOutlet weak var lblExperience: UILabel!
    
    
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblUniName: UILabel!
    
    @IBOutlet weak var lblDateFinish: UILabel!
    
    @IBOutlet weak var lblDegreeProgram: UILabel!
    
    @IBOutlet weak var tagList: TagListView!
    @IBOutlet weak var skillTaglist: TagListView!

    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var imgOfCompany: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : UserInfo) {
        
        lblUserNam.text = obj.user?.name
        lblAddress.text = obj.user?.location
        lblNumberOfExperience.text = "4 Years"
        lblExperience.text  = obj.user?.cover_letter
          guard let img = obj.user?.picture else {
            return
          }
          imgOfUser.setImage(with: img, placeholder: UIImage(named: "upload_photo"))
          let cgFloat: CGFloat = (imgOfUser.frame.size.width)/2.0
          let someFloat = Float(cgFloat)
          GeneralUtilities.setViewCornerRadius(imgOfUser , radius: CGFloat(someFloat))
//          lblJobTitle.text = obj.experince![0].title
          if obj.experince!.count > 0 {
            lblCompanyName.text = obj.experince![0].company
            lblUniName.text = obj.education![0].school
            let degree = obj.education![0].degree
            
            let field = obj.education![0].field
            lblDegreeProgram.text = "\(degree!), \n \(field!)"
            let start_date = obj.education![0].start_date
            let end_date = obj.education![0].end_date

            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
//            dateFormatter.timeZone = NSTimeZone(name: "UTC")
            let date = dateFormatter.date(from: start_date!)
            let enddate = dateFormatter.date(from: end_date!)

            dateFormatter.dateFormat = "yyyy"
            let startDate = dateFormatter.string(from: date!)
            let endDate = dateFormatter.string(from: enddate!)
            
            lblDateFinish.text = "\(startDate) - \(endDate)"
          }
         
//            let array = obj.user?.interests!.components(separatedBy: ",")
//            
//            for (_ , service) in ((array!.enumerated())) {
//                 tagList.addTag(service)
//             }
//        
//        let arryaOfSkill = obj.user?.skills?.components(separatedBy: ",")
//            for (_ , service) in ((arryaOfSkill!.enumerated())) {
//                       skillTaglist.addTag(service)
//            }
    }


}
