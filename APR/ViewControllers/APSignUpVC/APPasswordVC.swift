//
//  APPasswordVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APPasswordVC: UIViewController {
    var email : String?
    @IBOutlet var txtPassword : UITextField!
    @IBOutlet var txtConfirmPassword : UITextField!

    var presenter: RegistrationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassword.setLeftPaddingPoints(15.0)
        txtConfirmPassword.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        presenter?.validationOnChangePassword(password: txtPassword.text! , confirmPass: txtConfirmPassword.text!)
    }

}

extension APPasswordVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
//        self.showToast(message)
        self.showAlert(title: "Warning", message: message, controller: self)
    }
    func registrationDidSucceed(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APAccountTypeVC") as? APAccountTypeVC else {
            return
        }
        vc.email = email
        vc.password = txtPassword.text
        self.navigationController?.pushViewController(vc, animated: true )
    }
}
