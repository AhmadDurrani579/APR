//
//  GeneralUtilities.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 27/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import UIKit

class GeneralUtilities: NSObject {
    
    class func setViewCornerRadius(_ view: UIView, radius: CGFloat) {
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
    class func setViewBorder(_ view: UIView, withWidth width: CGFloat, andColor color: UIColor) {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1
    }
    

}
