//
//  APMessageListVC.swift
//  APR
//
//  Created by Ahmed Durrani on 01/12/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import GrowingTextView
import IQKeyboardManagerSwift
import Network

class APMessageListVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    @IBOutlet weak var lblName: UILabel!

    private  var messgeItemList: [ConversationListing]  = []
    var selectedMessage: MessageList?
    let commentDateForm = DateFormatter()
    @IBOutlet weak var txtEnter: GrowingTextView!
    @IBOutlet weak var chatViewBottomConstraint : NSLayoutConstraint!
    var toUserId: String = ""
    var  jobDetail : JobList?
    override func viewDidLoad() {
        super.viewDidLoad()
        messgeItemList = []
        
        lblName.text = selectedMessage?.name ?? jobDetail?.name
        
        if userObj?.id == selectedMessage?.to_user ?? jobDetail?.user_id {
            toUserId = selectedMessage?.from_user ?? jobDetail?.user_id ?? ""
        } else {
            toUserId = selectedMessage?.to_user ?? jobDetail?.user_id ?? ""
        }
        let param =          [     "touser"      : "\(toUserId)"  ,
                                   "fromuser"    :  userObj?.id ?? ""
                            ] as [String : Any]
        SKSocketConnection.socketSharedConnection.chatHistory(obj : param)

        commentDateForm.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        commentDateForm.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        
        
        tblView.registerCells([SenderCell.self  , ReceiverCell.self])
        NotificationCenter.default.addObserver(self, selector: #selector(self.didMessageDisplay(_:)), name: NSNotification.Name(rawValue: "messageReciver"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.appendNewMessage), name: NSNotification.Name(rawValue: "new Message"), object: nil)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
    }
    
    @objc func appendNewMessage(_ notification: NSNotification) {
        let messagess = notification.object as? NSDictionary
        let stringObj = messagess!
        let jsonData = try? JSONSerialization.data(withJSONObject: stringObj, options: [])
        let decoder = JSONDecoder()
        let userId = userObj?.id
        do {
            let mesgItem = try decoder.decode(ConversationListing.self, from: jsonData!)
            if mesgItem.from_user ==  Int(userId!) || mesgItem.to_user ==  Int(userId!) {
                messgeItemList.append(mesgItem)
                tblView.scrollToBottom()
                tblView.reloadData()
            }
        } catch {
          print(error.localizedDescription)
        }

    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        txtEnter.resignFirstResponder()
    }

    
    @objc func didMessageDisplay(_ notification: NSNotification) {
        
        let messagess = notification.object as? NSMutableArray
                
        let stringObj = messagess
        //        let stringObj = messagess!["data"] as? NSDictionary
        let jsonData = try? JSONSerialization.data(withJSONObject: stringObj!, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)
        let decoder = JSONDecoder()
        do {
            messgeItemList = try decoder.decode([ConversationListing].self, from: jsonData!)
        } catch {
            print(error.localizedDescription)
        }
        tblView.delegate = self
        tblView.dataSource = self
        tblView.estimatedRowHeight = 50.0
        tblView.rowHeight = UITableView.automaticDimension
        tblView.reloadData()
         if ((self.messgeItemList.count)) > 0 {
             self.tblView.scrollToBottom()
        }

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func btnGetHistory_Pressed(_ sender: UIButton) {
        if txtEnter.text.count > 0 {
//            let userId = UserDefaults.standard.string(forKey: "id")
//            let toUserId = selectedMessage?.to_user
            let fromUser = userObj?.id!
            let param =             [ "message"         : txtEnter.text! ,
                                      "touser"          : toUserId ,
                                      "fromuser"         : fromUser!
                                    ] as [String : Any]
            SKSocketConnection.socketSharedConnection.sendMessage(obj: param)
            self.txtEnter.text = ""

        } else {
            self.showToast("Enter Message")
        }
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
           let userInfo:NSDictionary = notification.userInfo! as NSDictionary
           let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
           let keyboardRectangle = keyboardFrame.cgRectValue
           let keyboardHeight = keyboardRectangle.height - 60
           self.chatViewBottomConstraint.constant = keyboardHeight
            if ((self.messgeItemList.count)) > 0 {
                self.tblView.scrollToBottom()
           }
        
       }
       
       @objc func keyboardWillHide(notification:NSNotification)  {
//           self.bottomViewBottomSpaceConstant.constant = 0.0
           self.chatViewBottomConstraint.constant = 10.0
       }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension APMessageListVC: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messgeItemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if messgeItemList[indexPath.row].from_user ==  Int((userObj?.id!)!) {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SenderCell", for: indexPath) as? SenderCell
                  cell?.lblMessage.text = messgeItemList[indexPath.row].message
                  let date = commentDateForm.date(from:(messgeItemList[indexPath.row].created_at)!)
                  if let timeAgo = WAShareHelper.timeAgoSinceDate(date!) {
                    cell!.lblTime.text = "\(timeAgo) ago"
                  } else {
                      print("recently")
                  }
                 return cell!

        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverCell", for: indexPath) as? ReceiverCell
            cell?.lblReceiverMessage.text = messgeItemList[indexPath.row].message
              let date = commentDateForm.date(from:(messgeItemList[indexPath.row].created_at)!)
              if let timeAgo = WAShareHelper.timeAgoSinceDate(date!) {
                cell!.lblTime.text = "\(timeAgo) ago"
              } else {
                  print("recently")
              }
            guard  let image = messgeItemList[indexPath.row].touserpicture  else   {
                return cell!
            }
            WAShareHelper.loadImage(urlstring:image , imageView: ((cell?.imgOfReceiver!)!), placeHolder: "profile")
            let cgFloat: CGFloat = cell!.imgOfReceiver.frame.size.width/2.0
            let someFloat = Float(cgFloat)
            WAShareHelper.setViewCornerRadius(cell!.imgOfReceiver, radius: CGFloat(someFloat))
             return cell!

        }
            
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


//"created_at" = "2020-12-01T10:14:59.000Z";
//file = "<null>";
//"from_user" = 4;
//fromusername = "<null>";
//fromuserpicture = "<null>";
//message = "Hi Ahmad";
//"to_user" = 5;
//tousername = Ahmad;
//touserpicture = "https://allpurposerecruiting.careers/app/assets/uploads/202007170642532020071706425360494.png";

struct ConversationListing : Codable {
    var created_at : String?
    var from_user : Int?
    var message :   String?
    var to_user :   Int?
    var tousername :   String?
    var touserpicture :   String?

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case from_user = "from_user"
        case message = "message"
        case to_user = "to_user"
        case tousername = "tousername"
        case touserpicture = "touserpicture"

    }
}

//
//"created_at" = "2020-12-01T10:14:59.000Z";
//file = "<null>";
//"from_user" = 4;
//fromusername = "<null>";
//fromuserpicture = "<null>";
//message = "Hi Ahmad";
//"to_user" = 5;
//tousername = Ahmad;
//touserpicture = "https://allpurposerecruiting.careers/app/assets/uploads/202007170642532020071706425360494.png";
//},
