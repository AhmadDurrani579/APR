//
//  JobDetailHeaderCell.swift
//  APR
//
//  Created by Ahmed Durrani on 04/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

protocol JobDetailDelegate : class {
    func back(cell : JobDetailHeaderCell)
    func profile(cell : JobDetailHeaderCell)
    func coverLetter(cell : JobDetailHeaderCell)
    func pitchVideo(cell : JobDetailHeaderCell)
    func setting(cell : JobDetailHeaderCell)
    func message(cell : JobDetailHeaderCell)
}
class JobDetailHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameOfUser: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewOfPersonal: UIView!
    @IBOutlet weak var viewOfCoverLetter: UIView!
    @IBOutlet weak var viewOfPitchVideo: UIView!
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnBAck: UIButton!
    
    weak var delegate : JobDetailDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        delegate?.back(cell: self)
    }
    
    @IBAction func btnPersonalInfo_Pressed(_ sender: UIButton) {
        delegate?.profile(cell: self)
        viewOfPersonal.isHidden = false
        viewOfCoverLetter.isHidden = true
        viewOfPitchVideo.isHidden = true
    }
    @IBAction func btnCoverLetter_Pressed(_ sender: UIButton) {
        delegate?.coverLetter(cell: self)
        viewOfPersonal.isHidden = true
        viewOfCoverLetter.isHidden = false
        viewOfPitchVideo.isHidden = true
    }
    @IBAction func btnPitchVideo_Pressed(_ sender: UIButton) {
        delegate?.pitchVideo(cell: self)
        viewOfPersonal.isHidden = true
        viewOfCoverLetter.isHidden = true
        viewOfPitchVideo.isHidden = false

    }

    @IBAction func btnSetting(_ sender: UIButton) {
        delegate?.setting(cell: self)
    }
    
    @IBAction func btnMessage_Pressed(_ sender: UIButton) {
        delegate?.message(cell: self)
    }

}
