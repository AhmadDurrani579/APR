//
//  APEmailVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APEmailVC: UIViewController {
    @IBOutlet var txtEmail : UITextField!
    var presenter: RegistrationPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)
    }
    
    @IBAction private func btnSelectEmail(_ sender : UIButton) {
        presenter?.EmailInfo(email: txtEmail.text!)
    }

   
}


//

extension APEmailVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showAlert(title: "Warning", message: message, controller: self)

    }
    func registrationDidSucceed(){
        
        let endPoint = AuthEndpoint.checkEmail(email: txtEmail.text!)
        showProgressIndicator(view: self.view)

              NetworkLayer.fetch(endPoint, with: EmailValidation.self) {[weak self] (result ) in
                  switch result {
                  case .success(let response):
                  if response.status == 200 {
//                    self!.showToast(response.message!)
                        self?.showAlert(title: "Warning", message: response.message!, controller: self)
                      hideProgressIndicator(view: self!.view)
                  } else {
                    hideProgressIndicator(view: self!.view)
                    guard let vc = self!.storyboard?.instantiateViewController(withIdentifier: "APPasswordVC") as? APPasswordVC else {
                        return
                    }
                    vc.email = self!.txtEmail.text
                    self!.navigationController?.pushViewController(vc, animated: true )

                  }
                  case .failure(_):
                    hideProgressIndicator(view: self!.view)
                      self!.showToast("Server Error")
                      break
              
                  }
                  }

    }
}

