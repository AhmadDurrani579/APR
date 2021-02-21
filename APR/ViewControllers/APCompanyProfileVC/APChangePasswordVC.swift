//
//  APChangePasswordVC.swift
//  APR
//
//  Created by Ahmed Durrani on 12/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APChangePasswordVC: UIViewController {
    var presenter: RegistrationPresenter?
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtRetypePassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPassword.setLeftPaddingPoints(15.0)
        txtRetypePassword.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnChanegPassword_Pressed(_ sender : UIButton) {
        presenter?.validationOnChangePassword(password: txtPassword.text!, confirmPass: txtRetypePassword.text!)
    }

}

extension APChangePasswordVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
        showProgressIndicator(view: self.view)
        let context = (self)

        let endPoint = AuthEndpoint.resetPassword(userId: userObj!.id!, password: txtPassword.text!)
        NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
            switch result {
            case .success(let response):
            if response.status == 200 {
                hideProgressIndicator(view: context.view)
                context.navigationController?.popViewController(animated: true)
            } else {
                context.showToast(response.message!)
                hideProgressIndicator(view: context.view)
            }
            case .failure(_):
                hideProgressIndicator(view: context.view)
                context.showToast("Server Error")
                break
        
            }
            }
         }
    
    
}
