//
//  APLoginVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APLoginVC: UIViewController {

    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var txtPassword: UITextField!
    var presenter: RegistrationPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.setLeftPaddingPoints(15.0)
        txtPassword.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)
//        txtEmail.text = "durranitrg@gmail.com" // professiona
////        txtEmail.text = "ahmadyar@gmail.com" // user
//        txtPassword.text = "Ahmad12345"
        
//        txtEmail.text = "allaudd3in22015@gmail.com"
//        txtPassword.text = "admin"
        
//                txtEmail.text = "kash@gmail.com"
//                txtPassword.text = "123456"


    }
    
    @IBAction private func btnSignIn_Pressed(_ sender : UIButton) {
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        guard let vc = storyboard.instantiateViewController(withIdentifier: "APJobListVC") as? APJobListVC else {
//        return
//        }
//        self.navigationController?.pushViewController(vc, animated: true )

        presenter?.signIn(email: txtEmail.text!, password: txtPassword.text!)
    }
}

extension APLoginVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
        self.showToast(message)
    }
    func registrationDidSucceed(){
        let persistence = Persistence(with: .user)
         showProgressIndicator(view: self.view)
          let context = (self)
          let endPoint = AuthEndpoint.login(email: txtEmail.text! , password: txtPassword.text!)
                NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
                    switch result {
                    case .success(let response):
                    if response.status == 200 {
                        persistence.save(response.data)
                        hideProgressIndicator(view: context.view)
                        if response.data?.type == "student" {
                            let storyboard = UIStoryboard(name: "Home", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "APStudentTabBarVC")
                            let nav = UINavigationController(rootViewController: vc)
                            nav.isNavigationBarHidden = true
                            UIApplication.shared.keyWindow?.rootViewController = nav
                        } else {
                            let storyboard = UIStoryboard(name: "Home", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "APTabBarVC")
                            let nav = UINavigationController(rootViewController: vc)
                            nav.isNavigationBarHidden = true
                            UIApplication.shared.keyWindow?.rootViewController = nav
                        }
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
