//
//  APAddSKillsVC.swift
//  APR
//
//  Created by Ahmed Durrani on 12/05/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APAddSKillsVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    private var skill : [SkillsList] = []
    private var  skillSelect : [String] = []
    private var  skilId : [String] = []
    var selectTag : [String] = []
    
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
             guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APSetLocationVC") as? APSetLocationVC else {
                        return
                    }
              vc.skillSelect = skillSelect
              vc.selectTag = selectTag
              self.navigationController?.pushViewController(vc, animated: true )
        } else {
            self.showToast("Select Skills")
        }
    }
}

extension APAddSKillsVC  : UITableViewDelegate , UITableViewDataSource {
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
extension APAddSKillsVC : SelectSkillDelegate {
    func selectSkill(cell: AddSkillCell, index: IndexPath) {
        
    }
}
