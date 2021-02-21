//
//  ChatListCell.swift
//  APR
//
//  Created by Ahmed Durrani on 01/12/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTme: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    let commentDateForm = DateFormatter()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj: MessageList) {
        commentDateForm.dateFormat = "yyyy-MM-dd HH:mm:ss"
        commentDateForm.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = commentDateForm.date(from:(obj.created_at)!)
        if let timeAgo = WAShareHelper.timeAgoSinceDate(date ?? Date()) {
          lblTme.text = "\(timeAgo) ago"
        } else {
            print("recently")
        }
        lblName.text = obj.name ?? "ABC"
        lblMessage.text = obj.message
        guard  let imgUrl = obj.picture  else   {
            imgOfUser.image = UIImage(named: "profile")
            let cgFloat: CGFloat = imgOfUser.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(imgOfUser, radius: CGFloat(someFloat))
            return
        }
        WAShareHelper.loadImage(urlstring:imgUrl , imageView: (imgOfUser), placeHolder: "profile")
        let cgFloat: CGFloat = imgOfUser.frame.size.width/2.0
        let someFloat = Float(cgFloat)
        WAShareHelper.setViewCornerRadius(imgOfUser, radius: CGFloat(someFloat))
    }
    
}
