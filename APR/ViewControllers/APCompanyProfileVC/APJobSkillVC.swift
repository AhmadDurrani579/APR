//
//  APJobSkillVC.swift
//  APR
//
//  Created by Ahmed Durrani on 15/06/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

protocol SelectSkillDelegatess : class {
    func selectSkills(interest : [String])
}

class APJobSkillVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    private var skill : [SkillsList] = []
    private var  skillSelect : [String] = []
    private var  skilId : [String] = []
    var selectTag : [String] = []
    
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
    var isComeFromFilter  = false
    weak var delegate : SelectSkillDelegatess?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.registerCells([AddSkillCell.self ])
        getSkills()
    }
    
    func getSkills() {
        let endPoint = AuthEndpoint.getSkillsList
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: Skills.self) { (result) in
          switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    context.skill = response.data ??  []
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
    
    @IBAction private func btnAddSkill_Pressed(_ sender : UIButton) {
        if skillSelect.count > 0 {
            if isComeFromFilter == true {
                delegate?.selectSkills(interest: skillSelect)
                self.navigationController?.popViewController(animated: true)
            } else {
             guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobDescriptionVC") as? APJobDescriptionVC else {
                        return
            }
              vc.skillSelect = skillSelect
              vc.jobTitle = jobTitle
              vc.location = location
              vc.experience = experience
              vc.position =   position
              vc.employementType =   employementType
              vc.salaryRange =   salaryRange
              vc.selectDate = selectDate
              vc.latitude = latitude
              vc.longitude = longitude
              vc.imageOfUseer = imageOfUseer
              vc.selectedTags = selectedTags
              self.navigationController?.pushViewController(vc, animated: true )
            }
        } else {
            self.showToast("Select Skills")
        }
    }


}

extension APJobSkillVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skill.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AddSkillCell.self, for: indexPath)
        cell.delegate = self
        cell.selectIndex = indexPath
        if let _ = skilId.firstIndex(of: skill[indexPath.row].id!) {
            cell.btnSelectSkill.isSelected = true
        } else {
            cell.btnSelectSkill.isSelected = false
        }
        cell.lblSkill.text = skill[indexPath.row].titleOfProgram
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AddSkillCell
        if cell.btnSelectSkill.isSelected == false {
            cell.btnSelectSkill.isSelected = true
            skillSelect.append(skill[indexPath.row].titleOfProgram!)
            skilId.append(skill[indexPath.row].id!)
        } else {
            cell.btnSelectSkill.isSelected = false
            if let index = skilId.firstIndex(of: skill[indexPath.row].id!) {
                skilId.remove(at: index)
            }
            if let indexss = skillSelect.firstIndex(of: skill[indexPath.row].titleOfProgram!) {
                skillSelect.remove(at: indexss)
            }
        }
        tableView.reloadData()
    }
}
extension APJobSkillVC : SelectSkillDelegate {
    func selectSkill(cell: AddSkillCell, index: IndexPath) {
        
    }
}
