//
//  APJobFairRegisterationVC.swift
//  APR
//
//  Created by Ahmed Durrani on 07/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APJobFairRegisterationVC: UIViewController {
    
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblCOmpanyName: UILabel!
//    @IBOutlet weak var lblJobTitleAnother: UILabel!
    @IBOutlet weak var lblDateAndTime: UILabel!

//    @IBOutlet weak var lblFreeOrPaid: UILabel!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    var job : JobFairList?
    var quantiy : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblJobTitle.text = job?.job_title
//        lblJobTitleAnother.text =  job?.job_title
        lblCOmpanyName.text = job?.company_name
        let startTime = job?.start_time
        let endTime = job?.end_time
        let dateOfJob = getFormattedDate(string: job!.start_date!)
        lblDateAndTime.text = "\(dateOfJob) from \(startTime!) - \(endTime!)"
//        lblFreeOrPaid.text = job?.price

        // Do any additional setup after loading the view.
    }
    
    func getFormattedDate(string: String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE, MMM d, yyyy"
        
        let date: Date? = dateFormatterGet.date(from: string)
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }


    @IBAction func btnRegister(_ sender: UIButton) {
        let context = (self)
        let userID = userObj?.id!
        showProgressIndicator(view: self.view)
        let endPoint = AuthEndpoint.eventRegistration(jobfair_id: job!.id!, quantity: quantiy!, first_name: txtFirstName.text ?? userObj!.name!, last_name: txtLastName.text ?? userObj!.name!, email_address: txtEmail.text ?? (userObj?.email!)!, user_id: userID!)
                showProgressIndicator(view: self.view)
                NetworkLayer.fetch(endPoint, with: JobFairResponse.self) { (result) in
                    switch result {
                    case .success(let response):
                        if response.success == true {
                            hideProgressIndicator(view: context.view)
                            self.navigationController?.popToRootViewController(animated: true)
                        } else {
                            hideProgressIndicator(view: context.view)
                            self.showToast(response.message)
                            print("Some thing wrong")
                        }
                    case .failure(_):
                        hideProgressIndicator(view: context.view)
                        break
                        
                    }

             }    }

}
