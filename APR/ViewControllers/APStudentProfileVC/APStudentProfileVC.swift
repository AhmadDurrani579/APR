//
//  APStudentProfileVC.swift
//  APR
//
//  Created by Ahmed Durrani on 12/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import TagListView

class APStudentProfileVC: UIViewController {
    
    private var userInfo : UserInfo?
    @IBOutlet var tblView: UITableView!
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectTag : [String] = []
    var selectSkill : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.registerCells([ProfileCell.self])
        
        NotificationCenter.default
        .addObserver(self,
         selector:#selector(methodOfReceivedNotification),
         name: NSNotification.Name(rawValue: "skillAdd"),
         object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(methodOfReceivedNotification) , name: Notification.Name("skillAdd"), object: nil , userInfo : nil)

        getUserInfo()
        // Do any additional setup after loading the view.
    }
    @objc func methodOfReceivedNotification() {
        getUserInfo()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblView.reloadData()
    }

    
    func getUserInfo() {
        let userId  = userObj?.id
        let endPoint = AuthEndpoint.profileStudent(userId: userId!)
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: Student.self) { (result) in
          switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    context.userInfo = response.data
                    userStudentInfo = response.data
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()

                } else {
                    hideProgressIndicator(view: self.view)
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

extension APStudentProfileVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ProfileCell.self, for: indexPath)
        cell.setCellData(obj: userInfo!)
        cell.tagList.textFont = UIFont.systemFont(ofSize: 16)
        cell.skillTaglist.textFont = UIFont.systemFont(ofSize: 16)
        let array = userInfo?.user?.interests!.components(separatedBy: ",")
        for (_ , service) in ((array!.enumerated())) {
            if selectTag.contains(service) == true {
            } else {
                selectTag.append(service)
                cell.tagList.addTag(service)
            }
        }
        let arrayOfSkill = userStudentInfo?.user?.skills!.components(separatedBy: ",")
        for (_ , service) in ((arrayOfSkill!.enumerated())) {
            if selectSkill.contains(service) == true {
            } else {
                selectSkill.append(service)
                cell.skillTaglist.addTag(service)
            }
        }
        
        cell.tagList.delegate = self
        cell.skillTaglist.delegate = self

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    
}

extension APStudentProfileVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
