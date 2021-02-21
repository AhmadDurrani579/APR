//
//  APNotificationVC.swift
//  APR
//
//  Created by Ahmed Durrani on 06/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APNotificationVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    private var notificationList : [NotificationList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([APNotificationCell.self])
        getNotification()
    }
    
    func getNotification() {
        let userId  = userObj?.id
        let endPoint = AuthEndpoint.notificationList(userId: userId!)
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: Notification.self) { (result) in
          switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    context.notificationList = response.data ??  []
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()
                } else {
                    hideProgressIndicator(view: self.view)
                    context.showToast(response.message)
                    context.tblView.delegate = self
                    context.tblView.dataSource = self
                    context.tblView.reloadData()

                    }
                  case .failure(_ ):
                        hideProgressIndicator(view: self.view)
                        context.showToast("Some thing wrong")
                    break
                 }

        }
      }

}

extension APNotificationVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        
        if  notificationList.isEmpty == false {
            numOfSections = 1
            tblView.backgroundView = nil
        }  else {
            let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblView.bounds.size.width, height: tblView.bounds.size.height))
            noDataLabel.numberOfLines = 10
            if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                noDataLabel.font = aSize
            }
            noDataLabel.text = "There are currently no Notification ."
            noDataLabel.textColor = UIColor.lightGray
            noDataLabel.textAlignment = .center
            tblView.backgroundView = noDataLabel
            tblView.separatorStyle = .none
        }
        return numOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: APNotificationCell.self, for: indexPath)
        cell.setCellData(obj: notificationList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114.0
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
