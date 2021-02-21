//
//  SwipeCell.swift
//  APR
//
//  Created by Ahmed Durrani on 20/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import Koloda
import TagListView

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class SwipeCell: OverlayView {

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
    @IBOutlet weak var skillTagList: TagListView!
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var imgOfCompany: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagList.textFont = UIFont.systemFont(ofSize: 13.0)
        skillTagList.textFont = UIFont.systemFont(ofSize: 13.0)

//        tagList.textFont = UIFont(name: "GT-Eesti-Pro-Display", size: 15.0)!
        // Initialization code
    }
    
   @IBOutlet lazy var overlayImageView: UIImageView! = {
       [unowned self] in
       var imageView = UIImageView(frame: self.bounds)
       self.addSubview(imageView)
       return imageView
       }()

   override var overlayState: SwipeResultDirection? {
       didSet {
           switch overlayState {
           case .left? :
               overlayImageView.image = UIImage(named: overlayLeftImageName)
           case .right? :
               overlayImageView.image = UIImage(named: overlayRightImageName)
           default:
               overlayImageView.image = nil
           }
       }
   }

    
}
