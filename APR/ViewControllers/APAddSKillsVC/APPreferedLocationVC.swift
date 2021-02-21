//
//  APPreferedLocationVC.swift
//  APR
//
//  Created by Ahmed Durrani on 12/05/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APPreferedLocationVC: UIViewController {

    @IBOutlet weak var txtLocation: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnAddSkill_Pressed(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobTypeSelectVC") as? APJobTypeSelectVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true )

    }
    @IBAction func btnUpDateLocation(_ sender: UIButton) {

    }
   

}



