//
//  APJobDescriptionVC.swift
//  APR
//
//  Created by Ahmed Durrani on 15/06/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APJobDescriptionVC: UIViewController {
    @IBOutlet var txtCompanyInfo  : UITextView!
    var jobTitle : String?
    var location : String?
    var experience  : String?
    var position   : String?
    var employementType   : String?
    var salaryRange   : String?
    var selectDate : String?
    var latitude : Double?
    var longitude : Double?
    var imageOfUseer : UIImage?
    var selectedTags : [String]?
    var skillSelect : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtCompanyInfo.placeholder = "Enter the Company Info"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnDone_Pressed(_ sender : UIButton) {
        let companyId  = userObj?.company_id
        let positionOfJob = position!
        let experineRequired = experience!
        let employment = employementType!
        
        let interest = selectedTags!.joined(separator: ",")
        let skilSelect = skillSelect!.joined(separator: ",")

        guard let data = imageOfUseer?.jpegData(compressionQuality: 0.5) else {
            return
        }
        let endPoint = AuthEndpoint.createJob(company_id: companyId! , job_title: jobTitle!  , position: positionOfJob , location: location! , experience: experineRequired , employment_type: employment , start_date:  selectDate! , latitude: "\(latitude ?? DEVICE_LAT)", longitude: "\(longitude ?? DEVICE_LONG)", salary: salaryRange!, descriptionOfJob: txtCompanyInfo.text ?? " ", skill : skilSelect , interest : interest , image: data)
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: AddJob.self) { (result) in
            switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    self.navigationController?.popToRootViewController(animated: true)
                    
                } else {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                }
            case .failure(_):
                hideProgressIndicator(view: self.view)
                context.showToast("Some thing wrong")
                break
            }
        }
    }
    
    
}
