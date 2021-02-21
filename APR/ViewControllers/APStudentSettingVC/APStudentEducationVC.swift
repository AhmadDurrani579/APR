//
//  APStudentEducationVC.swift
//  APR
//
//  Created by Ahmed Durrani on 11/03/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APStudentEducationVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.registerCells([EducationInfoCell.self ])
        tblView.rowHeight = 108.0
        tblView.estimatedRowHeight = UITableView.automaticDimension
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func btnAddEducation(_ sender : UIButton){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "APAddEducationInfoVC") as? APAddEducationInfoVC else {
            return
        }
        vc.delegate = self
        vc.isComeFromAddEducation = "1"

        self.navigationController?.pushViewController(vc, animated: true )
    }
}

extension APStudentEducationVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        if  userStudentInfo?.education?.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }  else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Education ."
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections

//        userStudentInfo
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (userStudentInfo?.education!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(with: EducationInfoCell.self, for: indexPath)
        cell.lblUniTitle.text = userStudentInfo?.education![indexPath.row].school
//                    lblUniName.text = obj.education![0].school
        let degree = userStudentInfo?.education![indexPath.row].degree
                    
        let field = userStudentInfo?.education![indexPath.row].field
        cell.lblUniProgram.text = "\(degree!), \n \(field!)"
        
        let start_date = userStudentInfo?.education![indexPath.row].start_date
        let end_date = userStudentInfo?.education![indexPath.row].end_date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: start_date!)
        let enddate = dateFormatter.date(from: end_date!)
        dateFormatter.dateFormat = "yyyy"
        let startDate = dateFormatter.string(from: date!)
        let endDate = dateFormatter.string(from: enddate!)

        cell.lblDate.text = "\(startDate) - \(endDate)"

            return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "KDServiceDetailVC") as? KDServiceDetailVC else {
//            return
//        }
//        vc.coach = coachList[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
//
//    }
    
}

extension APStudentEducationVC : AddEducationDelegate {
    func addEducation(education: EducationOfUser) {
        userStudentInfo?.education?.append(education)
        tblView.reloadData()
    }
}
