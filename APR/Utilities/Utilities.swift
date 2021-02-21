//
//  Utilities.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 26/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import Foundation
import UIKit
let PROGRESS_INDICATOR_VIEW_TAG:Int = 10


/* Show Progress Indicator */
func showProgressIndicator(view:UIView){
    
    view.isUserInteractionEnabled = false
    
    // Create and add the view to the screen.
    let progressIndicator = ProgressIndicator(text: "Please wait..")
    progressIndicator.tag = PROGRESS_INDICATOR_VIEW_TAG
    view.addSubview(progressIndicator)
    
}

/* Hide progress Indicator */
func hideProgressIndicator(view:UIView){
    
    view.isUserInteractionEnabled = true
    
    if let viewWithTag = view.viewWithTag(PROGRESS_INDICATOR_VIEW_TAG) {
        viewWithTag.removeFromSuperview()
    }
}

func addShadow(btn : UIButton) {
    btn.layer.shadowOpacity = 0.5
    btn.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
    btn.layer.shadowRadius = 5.0
    btn.layer.shadowColor = UIColor(red: 108/255.0, green: 165/255.0, blue: 67/255.0, alpha: 1.0).cgColor
}
