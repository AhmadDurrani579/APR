//
//  Storyboard.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 30/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import UIKit

protocol Storyboard {
    var name: String { get }
}

enum MainStoryboard: String, Storyboard {
    case Main = "Login"
    case homeTab = "GUTabBarController"
    var name: String {
        return "Home"
    }
}

extension UIViewController {
    class func from<S: Storyboard & RawRepresentable, T: UIViewController>(_ storyboard: S) -> T {
        return UIStoryboard(name: storyboard.name, bundle: nil).instantiateViewController(withIdentifier: storyboard.rawValue as! String) as! T
    }
}

