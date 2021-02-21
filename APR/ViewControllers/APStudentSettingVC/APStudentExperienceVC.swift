//
//  APStudentExperienceVC.swift
//  APR
//
//  Created by Ahmed Durrani on 11/03/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APStudentExperienceVC: UIViewController {
    @IBOutlet var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([ExperienceInfoCell.self ])
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
    }
    
    @IBAction private func btnAddEducation(_ sender : UIButton){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "APAddExperienceVC") as? APAddExperienceVC else {
            return
        }
        vc.isComeFromAddEducation = "1"
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true )
    }

}

extension APStudentExperienceVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if  userStudentInfo?.experince?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }  else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Experience ."
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections

//        userStudentInfo
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (userStudentInfo?.experince!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(with: ExperienceInfoCell.self, for: indexPath)
        cell.setExperience(obj: (userStudentInfo?.experince![indexPath.row])!)
//
            return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}

extension APStudentExperienceVC : AddExperienceDelegate {
    func addExperience(education: ExperienceOfUser) {
        userStudentInfo?.experince?.append(education)
        tblView.reloadData()
    }
}
