//
//  APCompanyLocation.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APCompanyLocation: UIViewController {
    var email : String?
    var password : String?
    var companyName : String?
    var cover_image: UIImage?
    var presenter: RegistrationPresenter?
    @IBOutlet var txtLocation  : UITextField!
    @IBOutlet var txtPhoneNum  : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtLocation.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)
        
    }

    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        presenter?.PhoneVerification(name: txtPhoneNum.text! , location: txtLocation.text!)
    }

    
}

extension APCompanyLocation  : RegistrationDelegate {
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
        vc.companyPhoneNum = txtPhoneNum.text ?? "12"
        vc.companyLocation = txtLocation.text!
        self.navigationController?.pushViewController(vc, animated: true )
    }
}
