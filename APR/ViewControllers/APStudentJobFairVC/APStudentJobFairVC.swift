//
//  APStudentJobFairVC.swift
//  APR
//
//  Created by Ahmed Durrani on 23/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APStudentJobFairVC: UIViewController {
    private var jobFair : [JobFairList] = []
    
    @IBOutlet weak var tblView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([JobFairCell.self])

        jobFairList()
        // Do any additional setup after loading the view.
    }
    
    func jobFairList() {
        let endPoint = AuthEndpoint.getJobFairs
        let context = (self)
        showProgressIndicator(view: self.view)

        NetworkLayer.fetch(endPoint, with: JobFair.self) { [weak self] (result) in
            switch result {
            case .success(let response) :
                if response.success == true {
                    hideProgressIndicator(view: context.view)
                    context.showToast(response.message)
                    context.jobFair = response.data ??  []
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()
                } else {
                    hideProgressIndicator(view: context.view)
                    context.showToast(response.message)
                }
            case .failure(_) :
                hideProgressIndicator(view: context.view)
                context.showToast("Some thing wrong")

            }
        }
    }
}

extension APStudentJobFairVC : UITableViewDelegate , UITableViewDataSource {
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
        return 127.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobFairDetailVC") as? APJobFairDetailVC
        vc?.jobFair = jobFair[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    
    
}
