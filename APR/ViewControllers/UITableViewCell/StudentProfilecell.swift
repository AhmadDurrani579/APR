//
//  StudentProfilecell.swift
//  APR
//
//  Created by Ahmed Durrani on 08/03/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
protocol AddProfilePhotoDelegate : class {
    func addPhoto(cell : StudentProfilecell)
}
class StudentProfilecell: UITableViewCell {

    @IBOutlet weak var userProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    weak var delegate : AddProfilePhotoDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction private func btnAddPhoto(_ sender : UIButton) {
        delegate?.addPhoto(cell: self)
    }
    
}
