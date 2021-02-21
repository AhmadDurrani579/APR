//
//  APJobTypeSelectVC.swift
//  APR
//
//  Created by Ahmed Durrani on 12/05/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

protocol JobSelectFilterdelegate : class  {
    func jobTypeSelect(selectJob : [String])
}
class APJobTypeSelectVC: UIViewController {
    
    @IBOutlet var tblView: UITableView!
    private var jobType : [JobTypeList] = []
    private var  jobSelect : [String] = []
    private var  jobID : [String] = []
    var selectTag : [String]?
    var skillSelect : [String]?
    var selectLocation : String?
    var radius : Int?
    weak var delegate : JobSelectFilterdelegate?
    var isComeFromFilter = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([JobTypeSelectionCell.self ,JobTypeHeaderCell.self ])
        getJobType()
    }
    
    func getJobType() {
        let endPoint = AuthEndpoint.getJobTypeList
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: JobType.self) { (result) in
          switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    context.jobType = response.data ??  []
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()
                    context.tblView.rowHeight = UITableView.automaticDimension
                    context.tblView.estimatedRowHeight = 60.0

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
    
//    @IBAction private func btnAddSkill_Pressed(_ sender : UIButton) {

//    }

    @IBAction private func btnAddSkill_Pressed(_ sender : UIButton) {
        if jobSelect.count > 0 {
            if isComeFromFilter == true  {
                delegate?.jobTypeSelect(selectJob: jobSelect)
                self.navigationController?.popViewController(animated: true)
            } else {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APGenderSelectVC") as? APGenderSelectVC else {
                    return
                 }
                    vc.selectTag = selectTag
                    vc.jobSelect = jobSelect
                    vc.skillSelect = skillSelect
                    vc.selectLocation = selectLocation
                    vc.radius = radius
                self.navigationController?.pushViewController(vc, animated: true )

            }
        } else {
            self.showToast("Select Job Type")

        }
    }
}

extension APJobTypeSelectVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return jobType.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: JobTypeHeaderCell.self, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(with: JobTypeSelectionCell.self, for: indexPath)
            cell.lblJobType.text = jobType[indexPath.row].job_type
            if let _ = jobID.firstIndex(of: jobType[indexPath.row].id!) {
                cell.btnJobType.isSelected = true
            } else {
                cell.btnJobType.isSelected = false
            }
            cell.delegate = self
            cell.selectIndex  = indexPath
            return cell

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 166.0
        } else {
            return 68.0
        }
        
    }
}

extension APJobTypeSelectVC : SelectJobTypeDelegate {
    func selectJobType(cell : JobTypeSelectionCell , index : IndexPath) {
        if cell.btnJobType.isSelected == true {
            cell.btnJobType.isSelected = true
            jobSelect.append(jobType[index.row].job_type!)
            jobID.append(jobType[index.row].id!)
        } else {
            cell.btnJobType.isSelected = false
            if let index = jobID.firstIndex(of: jobType[index.row].id!) {
                jobID.remove(at: index)
            }
            if let indexss = jobSelect.firstIndex(of: jobType[index.row].job_type!) {
                jobSelect.remove(at: indexss)
            }
        }
    }
}
