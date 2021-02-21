//
//  APStudentTabBarVC.swift
//  APR
//
//  Created by Ahmed Durrani on 22/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APStudentTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items![0].selectedImage = UIImage(named:"home selected")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![0] ).image = UIImage(named:"HOMEUn")!.withRenderingMode(.alwaysOriginal)
      
        self.tabBar.items![1].selectedImage = UIImage(named:"notifications selected")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![1] ).image = UIImage(named:"notifications")!.withRenderingMode(.alwaysOriginal)

        self.tabBar.items![2].selectedImage = UIImage(named:"job fair selected")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![2] ).image = UIImage(named:"job fair")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![3].selectedImage = UIImage(named:"msg selected")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![3] ).image = UIImage(named:"msg")!.withRenderingMode(.alwaysOriginal)
        self.tabBar.items![4].selectedImage = UIImage(named:"profile selected")!.withRenderingMode(.alwaysOriginal)
        (self.tabBar.items![4] ).image = UIImage(named:"profile")!.withRenderingMode(.alwaysOriginal)
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()

        // Do any additional setup after loading the view.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
