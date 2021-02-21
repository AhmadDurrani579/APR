//
//  APAccountTypeVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APAccountTypeVC: UIViewController {
    var email : String?
    var password : String?
    @IBOutlet weak var btnStudent: UIButton!
    @IBOutlet weak var btnEmployee: UIButton!
    var accountType : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        WAShareHelper.setBorderAndCornerRadius(layer: btnStudent.layer, width: 1.0, radius: 30.0, color: UIColor.lightGray)
        WAShareHelper.setBorderAndCornerRadius(layer: btnEmployee.layer, width: 1.0, radius: 30.0, color: UIColor.lightGray)
    }
    
    @IBAction private func btnStundetSelect(_ sender : UIButton) {
        WAShareHelper.setBorderAndCornerRadius(layer: btnStudent.layer, width: 1.0, radius: 30.0, color: UIColor(red: 33/255.0, green: 195/255.0, blue: 240/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: btnEmployee.layer, width: 1.0, radius: 30.0, color: UIColor.lightGray)
        btnStudent.titleLabel?.textColor = UIColor(red: 33/255.0, green: 195/255.0, blue: 240/255.0, alpha: 1.0)
        btnEmployee.titleLabel?.textColor = UIColor.lightGray
        accountType = "student"

    }
    
    @IBAction private func btnEmployeeSelect(_ sender : UIButton) {
        WAShareHelper.setBorderAndCornerRadius(layer: btnEmployee.layer, width: 1.0, radius: 30.0, color: UIColor(red: 33/255.0, green: 195/255.0, blue: 240/255.0, alpha: 1.0))
        WAShareHelper.setBorderAndCornerRadius(layer: btnStudent.layer, width: 1.0, radius: 30.0, color: UIColor.lightGray)
        btnEmployee.titleLabel?.textColor = UIColor(red: 33/255.0, green: 195/255.0, blue: 240/255.0, alpha: 1.0)
        btnStudent.titleLabel?.textColor = UIColor.lightGray
        accountType = "employee"

    }
    
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
    if accountType == nil {
        self.showToast("Select Account Type")
    } else {
        
        if accountType == "student" {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APNameVC") as? APNameVC else {
                return
            }
            vc.email = email
            vc.password = password
            vc.accountType = accountType
            self.navigationController?.pushViewController(vc, animated: true )
        } else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCompanyNameVC") as? APCompanyNameVC else {
                return
            }
            vc.email = email
            vc.password = password
//            vc.accountType = accountType
            self.navigationController?.pushViewController(vc, animated: true )

        }

    }

    }
    
}
