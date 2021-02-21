//
//  APCompanyInfoVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APCompanyInfoVC: UIViewController {
    var email : String?
    var password : String?
    var companyName : String?
    var cover_image: UIImage?
    var companyLocation : String?
    var companyPhoneNum : String?
    var presenter: RegistrationPresenter?
    
    @IBOutlet var txtCompanyInfo  : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCompanyInfo.placeholder = "Enter the Company Info"

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnDone_Pressed(_ sender : UIButton) {
        presenter?.NameInfo(name: txtCompanyInfo.text!, imageSelect: true)
        if txtCompanyInfo.text.count > 3 {
            let persistence = Persistence(with: .user)
            let context = (self)
                
                
            guard let data = cover_image?.jpegData(compressionQuality: 0.5) else {
                return
             }
                let endPoint = AuthEndpoint.employeeSignUp(email: email! , location: companyLocation! , password: password! , type:"employee" , company_name: companyName!, phone_number: companyPhoneNum!, latitude: "\(DEVICE_LAT)", longitude: "\(DEVICE_LONG)", company_info: txtCompanyInfo.text! , image: data)
                        showProgressIndicator(view: self.view)
                        NetworkLayer.fetch(endPoint, with: CompanyRegistration.self) { (result) in
                            switch result {
                            case .success(let response):
                                if response.success == true {
                                    persistence.save(response.data)
                                    hideProgressIndicator(view: context.view)
                                    self.navigationController?.popToRootViewController(animated: true)
                //                    context?.didSignUp(with: response.message)
                                } else {
                                    hideProgressIndicator(view: context.view)

                //                    context?.didFailSignUp(with: response.message)
                                    print("Some thing wrong")
                                    
                                }
                            case .failure(let error):
                            hideProgressIndicator(view: context.view)
                                        break
                            }

                     }
        } else {
            self.showAlert(title: "Warning", message: "Please enter the company description", controller: self)
        }
    }

}

