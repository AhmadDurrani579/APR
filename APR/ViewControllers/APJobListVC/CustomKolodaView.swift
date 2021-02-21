//
//  CustomKolodaView.swift
//  Koloda
//
//  Created by Eugene Andreyev on 7/11/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import Koloda

let defaultTopOffset: CGFloat = 2
let defaultHorizontalOffset: CGFloat = 2
let defaultHeightRatio: CGFloat = 1
let backgroundCardHorizontalMarginMultiplier: CGFloat = 0.25
let backgroundCardScalePercent: CGFloat = 1.5

class CustomKolodaView: KolodaView {

    override func frameForCard(at index: Int) -> CGRect {
        if index == 0 {
            let topOffset: CGFloat = defaultTopOffset
            let xOffset: CGFloat = defaultHorizontalOffset
            let width = SCREEN_WIDTH
//            let height = width * defaultHeightRatio
            let yOffset: CGFloat = topOffset
            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: SCREEN_HEGHT)
            
            return frame
        } else if index == 1 {
            let horizontalMargin = -self.bounds.width * backgroundCardHorizontalMarginMultiplier
//            let width = self.bounds.width * backgroundCardScalePercent
//            let height = width * defaultHeightRatio
            return CGRect(x: horizontalMargin, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEGHT)
        }
        return CGRect.zero
    }

}