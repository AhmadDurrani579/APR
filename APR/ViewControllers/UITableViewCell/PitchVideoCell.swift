//
//  PitchVideoCell.swift
//  APR
//
//  Created by Ahmed Durrani on 03/06/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
protocol PlayVideoDelegate : class {
    func playVideo(cell : PitchVideoCell)
}
class PitchVideoCell: UITableViewCell {

    @IBOutlet weak var imgOfVideo: UIImageView!
    weak var delegate : PlayVideoDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnPlayVideo(_ sender: UIButton) {
        delegate?.playVideo(cell: self)
    }
    
}
