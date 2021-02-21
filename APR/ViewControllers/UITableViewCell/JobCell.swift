//
//  JobCell.swift
//  APR
//
//  Created by Ahmed Durrani on 03/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var imgOfJob: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    
    @IBOutlet weak var lblJobType: UILabel!
    
    @IBOutlet weak var lblCompanyName: UILabel!
    let dateFormat = "yyyy-MM-dd"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : CompanyJobList ) {
        lblTitle.text = obj.job_title
        lblLocation.text = obj.location
        lblCompanyName.text    = obj.company_name
        if obj.start_date == "0000-00-00" {
            lblTimeAgo.text = "0000-00-00"
        } else {
            lblTimeAgo.text = timeInterval(timeAgo: obj.start_date!)
        }
        lblJobType.text = obj.employment_type
        guard let imgeOfCompany = obj.job_picture  else {
            return
        }
        imgOfJob.setImage(with: imgeOfCompany, placeholder: UIImage(named: "jobFair"))
    }

    func timeInterval(timeAgo:String) -> String
        {
            let df = DateFormatter()

            df.dateFormat = dateFormat
            let dateWithTime = df.date(from: timeAgo)

            let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime!, to: Date())

            if let year = interval.year, year > 0 {
                return year == 1 ? "\(year)" + " " + "year ago" : "\(year)" + " " + "years ago"
            } else if let month = interval.month, month > 0 {
                return month == 1 ? "\(month)" + " " + "month ago" : "\(month)" + " " + "months ago"
            } else if let day = interval.day, day > 0 {
                return day == 1 ? "\(day)" + " " + "day ago" : "\(day)" + " " + "days ago"
            }else if let hour = interval.hour, hour > 0 {
                return hour == 1 ? "\(hour)" + " " + "hour ago" : "\(hour)" + " " + "hours ago"
            }else if let minute = interval.minute, minute > 0 {
                return minute == 1 ? "\(minute)" + " " + "minute ago" : "\(minute)" + " " + "minutes ago"
            }else if let second = interval.second, second > 0 {
                return second == 1 ? "\(second)" + " " + "second ago" : "\(second)" + " " + "seconds ago"
            } else {
                return "a moment ago"

            }
        }

}

