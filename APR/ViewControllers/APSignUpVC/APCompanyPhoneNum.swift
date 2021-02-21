//
//  APCompanyPhoneNum.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APCompanyPhoneNum: UIViewController {
    var email : String?
    var password : String?
    var companyName : String?
    var cover_image: UIImage?
    var companyLocation : String?
    var presenter: RegistrationPresenter?
    
    @IBOutlet var txtPhoneNum  : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPhoneNum.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCompanyInfoVC") as? APCompanyInfoVC else {
            return
        }
        vc.email = email
        vc.password = password
        vc.companyName = companyName!
        vc.cover_image = cover_image
        vc.companyLocation = companyLocation!
        vc.companyPhoneNum = txtPhoneNum.text ?? "112"
        self.navigationController?.pushViewController(vc, animated: true )
    }
}

extension APCompanyPhoneNum   : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCompanyInfoVC") as? APCompanyInfoVC else {
            return
        }
        vc.email = email
        vc.password = password
        vc.companyName = companyName!
        vc.cover_image = cover_image
        vc.companyLocation = companyLocation!
        vc.companyPhoneNum = txtPhoneNum.text
        self.navigationController?.pushViewController(vc, animated: true )
    }
}
