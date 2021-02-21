//
//  APAddSkillVC.swift
//  APR
//
//  Created by Ahmed Durrani on 06/06/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APAddSkillVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    private var skill : [SkillsList] = []
    private var  skillSelect : [String] = []
//    private var  skilId : [String] = []
    var isTagSkillSelect = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let arryaOfSkill = userStudentInfo?.user?.skills?.components(separatedBy: ",")
            for (_ , service) in ((arryaOfSkill!.enumerated())) {
                skillSelect.append(service)
            }
        tblView.registerCells([AddSkillCell.self ])
        getSkills()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        if  isTagSkillSelect == true {
            let skilSelect = skillSelect.joined(separator: ",")
             showProgressIndicator(view: self.view)
              let context = (self)
                let authPoint = AuthEndpoint.addSkill(userId: userObj!.id!, skills: skilSelect)
                NetworkLayer.fetch(authPoint, with: LoginResponse.self) {[weak self] (result) in
                switch result {
                case .success(let response):
                if response.status == 200 {
                    self?.showToast(response.message)
                    hideProgressIndicator(view: context.view)
                    NotificationCenter.default
                    .post(name:
                     NSNotification.Name("skillAdd"),
                     object: nil,
                     userInfo: nil)

                } else {
                    context.showToast(response.message!)
                    hideProgressIndicator(view: context.view)
                }
                case .failure(_):
                    hideProgressIndicator(view: context.view)
                    
                    context.showToast("Server Error")
                    break

                }
        }
    }
    }
    
}

extension APAddSkillVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skill.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: AddSkillCell.self, for: indexPath)
//        cell.delegate = self
        cell.selectIndex = indexPath
        if let _ = skillSelect.firstIndex(of: skill[indexPath.row].titleOfProgram!) {
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
            isTagSkillSelect = true
            cell.delegate = self
            skillSelect.append(skill[indexPath.row].titleOfProgram!)
//            skilId.append(skill[indexPath.row].id!)
        } else {
            cell.btnSelectSkill.isSelected = false
            isTagSkillSelect = false
            if let indexss = skillSelect.firstIndex(of: skill[indexPath.row].titleOfProgram!) {
                skillSelect.remove(at: indexss)
            }
        }
        tableView.reloadData()
    }
}
extension APAddSkillVC : SelectSkillDelegate {
    func selectSkill(cell: AddSkillCell, index: IndexPath) {
        
    }
}
