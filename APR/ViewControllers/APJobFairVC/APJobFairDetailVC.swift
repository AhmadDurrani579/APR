//
//  APJobFairDetailVC.swift
//  APR
//
//  Created by Ahmed Durrani on 06/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APJobFairDetailVC: UIViewController {
    var jobFair : JobFairList?
    @IBOutlet var tblView: UITableView!
    var isComeFromUserOrProfessional : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([JobFairDetailCell.self ,  JobFairAbout.self , JobFairLocationCell.self])
        tblView.estimatedRowHeight = 101.0
        tblView.rowHeight = UITableView.automaticDimension
        tblView.reloadData()
    }
  
}

extension APJobFairDetailVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: JobFairDetailCell.self, for: indexPath)
            cell.setCellData(obj: jobFair!)
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(with: JobFairAbout.self, for: indexPath)
            cell.setCellData(obj: jobFair!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: JobFairLocationCell.self, for: indexPath)
            cell.delegate = self
            if isComeFromUserOrProfessional == "profession" {
                cell.btnRegister.isHidden = true
            } else {
                  cell.btnRegister.isHidden = false
            }
            cell.setCellData(obj: jobFair!)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 468.0
        } else if indexPath.section == 1 {
            return UITableView.automaticDimension
        } else {
            return 390.0
        }
    }
}
extension APJobFairDetailVC : RegistrationTicketDelegate {
    func clickOnRegisterButton(cell: JobFairLocationCell) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobFairTicketDetailVC") as? APJobFairTicketDetailVC
        vc?.job = jobFair
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    
}

