//
//  APCurrentJobListVC.swift
//  APR
//
//  Created by Ahmed Durrani on 05/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APCurrentJobListVC: UIViewController {
    private var companyJob : [CompanyJobList] = []
    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
//148
        
        tblView.registerCells([JobCell.self])
        companyJobList()
    }
    
    @IBAction private func btnAddJob_Pressed(_ sender : UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "APAddJobVC") as? APAddJobVC
        vc?.delegate = self
        self.navigationController?.pushViewController(vc! , animated: true)
//         if #available(iOS 10.0 , *)  {
//                   vc?.modalPresentationStyle = .overCurrentContext
//               } else {
//                   vc?.modalPresentationStyle = .currentContext
//               }
//               vc?.delegate = self
//               vc?.providesPresentationContextTransitionStyle = true
//               present(vc!, animated: true) {
//            }
    }
    
    func companyJobList() {
        let endPoint = AuthEndpoint.getJobs(companyId: (userObj?.company_id!)!)
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: JobListOfCompany.self) { (result) in
          switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    context.companyJob = response.data ??  []
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()

                } else {
                    hideProgressIndicator(view: self.view)
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()

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

extension APCurrentJobListVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  companyJob.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }  else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Jobs ."
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyJob.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: JobCell.self, for: indexPath)
        cell.setCellData(obj: companyJob[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
}

extension APCurrentJobListVC : AddJobDelegate {
    func addJobDelegate(job: CompanyJobList) {
        companyJob.append(job)
        tblView.reloadData()
    }
    
    
}
