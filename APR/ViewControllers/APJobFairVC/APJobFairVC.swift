//
//  APJobFairVC.swift
//  APR
//
//  Created by Ahmed Durrani on 03/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APJobFairVC: UIViewController {
    private var jobFair : [JobFairList] = []
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([JobFairCell.self])
        tblView.estimatedRowHeight = 80.0
        tblView.rowHeight = UITableView.automaticDimension
        getJobFair()
    }

    @IBAction private func btnAddJobFair(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobFairdAddVC") as? APJobFairdAddVC else {
            return
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func getJobFair() {
        let endPoint = AuthEndpoint.getJobFairs
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: JobFair.self) { (result) in
          switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    context.jobFair = response.data ??  []
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()

                } else {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    }
                  case .failure(_ ):
                        hideProgressIndicator(view: self.view)
                        context.showToast("Some thing wrong")
                        break
                 }

        }
      }
}

extension APJobFairVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobFair.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: JobFairCell.self, for: indexPath)
        cell.setCellData(obj: jobFair[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobFairDetailVC") as? APJobFairDetailVC
        vc?.jobFair = jobFair[indexPath.row]
        vc?.isComeFromUserOrProfessional = "profession"
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
extension APJobFairVC : JobFairAddDelegate {
    func addJobFair(obj: JobFairList) {
        self.jobFair.append(obj)
        tblView.reloadData()
    }
}
