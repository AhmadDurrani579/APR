//
//  APNameVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APNameVC: UIViewController {
    @IBOutlet var txtName : UITextField!
    var presenter: RegistrationPresenter?
//    var selectGender : String?
    var email : String?
    var password : String?
    var accountType : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnSelectName(_ sender : UIButton) {
           presenter?.NameInfo(name : txtName.text! , imageSelect: true)
       }
   

}

extension APNameVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
        self.showAlert(title: "Warning", message: message, controller: self)

    }
    func registrationDidSucceed(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APUploadPicVC") as? APUploadPicVC else {
            return
        }
        vc.email = email
        vc.password = password
        vc.accountType = accountType
//        vc.selectGender = selectGender
        vc.userName = txtName.text ?? " "
        self.navigationController?.pushViewController(vc, animated: true )
    }
}


