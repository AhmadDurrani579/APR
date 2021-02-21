//
//  HomePresentable.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 30/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import Foundation

import UIKit

protocol HomePresentable: class {
    func showHome()
}

extension HomePresentable where Self: UIViewController {
    func showHome() {
        let homeTab = UITabBarController.from(MainStoryboard.homeTab)
        UIApplication.shared.keyWindow?.rootViewController = homeTab
    }
}
