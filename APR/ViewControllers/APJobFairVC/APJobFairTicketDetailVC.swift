//
//  APJobFairTicketDetailVC.swift
//  APR
//
//  Created by Ahmed Durrani on 06/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APJobFairTicketDetailVC: UIViewController {

    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblCOmpanyName: UILabel!
    @IBOutlet weak var lblJobTitleAnother: UILabel!
    @IBOutlet weak var lblDateAndTime: UILabel!

    @IBOutlet weak var lblFreeOrPaid: UILabel!
    @IBOutlet weak var txtQuantity: UITextField!
    var job : JobFairList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblJobTitle.text = job?.job_title
        lblJobTitleAnother.text =  job?.job_title
        lblCOmpanyName.text = job?.company_name
        let startTime = job?.start_time
        let endTime = job?.end_time
        let dateOfJob = getFormattedDate(string: job!.start_date!)
        lblDateAndTime.text = "\(dateOfJob) from \(startTime!) - \(endTime!)"
        lblFreeOrPaid.text = job?.price
        
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
        
        if txtQuantity.text!.count > 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobFairRegisterationVC") as? APJobFairRegisterationVC
            vc?.quantiy = txtQuantity.text
            vc?.job = job
            self.navigationController?.pushViewController(vc!, animated: true)
        } else {
            self.showToast("Please enter the Quantity")
        }
    }
    

}
