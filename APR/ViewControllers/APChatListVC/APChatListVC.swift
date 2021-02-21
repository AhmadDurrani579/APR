//
//  APChatListVC.swift
//  APR
//
//  Created by Ahmed Durrani on 01/12/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APChatListVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    private  var messgeItemList : [MessageList]  = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([ChatListCell.self])
//
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.userListDisplay(_:)), name: NSNotification.Name(rawValue: "AllChatList"), object: nil)
        getAllChat()
    }
    
    @objc func userListDisplay(_ notification: NSNotification) {
        let messagess = notification.object as? NSMutableArray
        let stringObj = messagess
        //        let stringObj = messagess!["data"] as? NSDictionary
        let jsonData = try? JSONSerialization.data(withJSONObject: stringObj!, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)
        let decoder = JSONDecoder()
        do {
            messgeItemList = try decoder.decode([MessageList].self, from: jsonData!)
            print(messgeItemList)
        } catch {
            print(error.localizedDescription)
        }
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 50.0
        tblView.rowHeight = UITableView.automaticDimension
        tblView.reloadData()
//         if ((self.messgeItemList.count)) > 0 {
//             self.tblViewss.scrollToBottom()
//        }

        
    }
    
    func getAllChat() {
        
//        "from_user" = 4;
//        message = "Hi Ahmad";
//        name = Ahmad;
//        picture = "https://allpurposerecruiting.careers/app/assets/uploads/202007170642532020071706425360494.png";
//        "to_user" = 5;
        
//        let param =          [     "touser"      : "5"  ,
//                                   "fromuser" : userObj?.id ?? ""
//
//                                ] as [String : Any]
//        SKSocketConnection.socketSharedConnection.chatHistory(obj : param)
//
        let param =             ["fromuser"          : userObj?.id ?? ""
                                ] as [String : Any]
        SKSocketConnection.socketSharedConnection.getChatList(obj: param)
    }
}

extension APChatListVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messgeItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: ChatListCell.self, for: indexPath)
        cell.setCellData(obj: messgeItemList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APMessageListVC") as? APMessageListVC else {
            return
        }
        
        vc.selectedMessage = messgeItemList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)

    }
}


struct MessageList : Codable {
    var from_user : String?
    var message : String?
    var name : String?
    var picture : String?
    var to_user :   String?
    var created_at: String?
//    var id: Int?
    
    
    enum CodingKeys: String, CodingKey {
        case from_user = "from_user"
        case message = "message"
        case name = "name"
        case picture = "picture"
        case to_user = "to_user"
        case created_at = "created_at"
//        case id = "id"

    }
    
}


