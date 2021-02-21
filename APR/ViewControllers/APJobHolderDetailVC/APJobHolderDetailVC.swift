//
//  APJobHolderDetailVC.swift
//  APR
//
//  Created by Ahmed Durrani on 04/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import TagListView
import AVFoundation
import AVKit


class APJobHolderDetailVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var  jobDetail : JobList?
    var isSelectProfileOrCoverLEtterOrPitchVideo : Int?
    
    var selectTag : [String] = []
    var selectSkill : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let param =             [ "message"         : "Hi Ahmad" ,
//                                  "touser"          : jobDetail?.user_id ?? "" ,
//                                  "fromuser"          : userObj?.id ?? "" ,
//                                ] as [String : Any]
//        SKSocketConnection.socketSharedConnection.sendMessage(obj: param)

        isSelectProfileOrCoverLEtterOrPitchVideo = 0
        tblView.registerCells([JobDetailHeaderCell.self  , UserProfileCell.self  , CoverLetterCell.self , PitchVideoCell.self])
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 346.0
        
    }
}

extension APJobHolderDetailVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: JobDetailHeaderCell.self, for: indexPath)
            cell.nameOfUser.text = jobDetail?.name
            cell.lblLocation.text = jobDetail?.location
            cell.lblDescription.text = jobDetail?.descriptionOfUser
            cell.delegate = self
            guard let img = jobDetail?.picture else {
                return cell
            }
            WAShareHelper.loadImage(urlstring:img , imageView: ((cell.profileImage!)), placeHolder: "profile")
            let cgFloat: CGFloat = (cell.profileImage.frame.size.width)/2.0
            let someFloat = Float(cgFloat)
            GeneralUtilities.setViewCornerRadius(cell.profileImage , radius: CGFloat(someFloat))
            return cell
        } else {
            if isSelectProfileOrCoverLEtterOrPitchVideo == 0 {
                let cell = tableView.dequeueReusableCell(with: UserProfileCell.self, for: indexPath)
                cell.lblJobTitle.text = jobDetail?.experince![0].title
                cell.lblCompanyName.text = jobDetail?.experince![0].company
                cell.lblUniName.text = jobDetail?.education![0].school
                let degree = jobDetail?.education![0].degree
                let field = jobDetail?.education![0].field
                cell.lblDegreeProgram.text = "\(degree!) , \(field!)"
                let start_date = jobDetail?.education![0].start_date
                let end_date = jobDetail?.education![0].end_date
                cell.lblDateFinish.text = "\(start_date!) - \(end_date!)"
                
                
//                let arrayOfSkill = jobDetail?.skills!.components(separatedBy: ",")
//                for (_ , skill) in ((arrayOfSkill!.enumerated())) {
//                    if selectSkill.contains(skill) == true {
//                    } else {
//                        selectSkill.append(skill)
//                        cell.skillTagList.addTag(skill)
//                    }
//                }
//                let array = jobDetail?.interests!.components(separatedBy: ",")
//                for (_ , service) in ((array!.enumerated())) {
//                    if selectTag.contains(service) == true {
//                    } else {
//                        selectTag.append(service)
//                        cell.tagList.addTag(service)
//                    }
//                }
//                cell.skillTagList.delegate = self
//                cell.tagList.delegate = self
                
                let array = jobDetail?.interests!.components(separatedBy: ",")
                for (_ , service) in ((array!.enumerated())) {
                    if selectTag.contains(service) == true {
                    } else {
                        selectTag.append(service)
                        cell.tagList.addTag(service)
                    }
                }
                let arrayOfSkill = jobDetail?.skills!.components(separatedBy: ",")
                for (_ , service) in ((arrayOfSkill!.enumerated())) {
                    if selectSkill.contains(service) == true {
                    } else {
                        selectSkill.append(service)
                        cell.skillTagList.addTag(service)
                    }
                }
                return cell
            } else if isSelectProfileOrCoverLEtterOrPitchVideo == 1  {
                let cell = tableView.dequeueReusableCell(with: CoverLetterCell.self, for: indexPath)
                cell.txtCoverLetter.text = jobDetail?.cover_letter
                return cell

            } else {
                let cell = tableView.dequeueReusableCell(with: PitchVideoCell.self, for: indexPath)
                AVAsset(url: URL(string: (jobDetail!.pitch_video)!)!).generateThumbnail { [weak self] (image) in
                    DispatchQueue.main.async {
                        guard let image = image else { return }
                        cell.imgOfVideo.image = image
                    }
                }

                cell.delegate = self

                return cell

            }

        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension

        } else {
            if isSelectProfileOrCoverLEtterOrPitchVideo == 0 {
                return UITableView.automaticDimension
            } else {
                return 297.0
            }
        }
    }
}

extension APJobHolderDetailVC : PlayVideoDelegate {
    func playVideo(cell : PitchVideoCell)  {
        let videoURL = URL(string: (jobDetail!.pitch_video)!)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }

    }
 
}


extension APJobHolderDetailVC : JobDetailDelegate {
    func setting(cell: JobDetailHeaderCell) {
        
    }
    func profile(cell: JobDetailHeaderCell) {
        isSelectProfileOrCoverLEtterOrPitchVideo = 0
        tblView.reloadData()
    }
    
    func coverLetter(cell: JobDetailHeaderCell) {
        isSelectProfileOrCoverLEtterOrPitchVideo = 1
        tblView.reloadData()
    }
    func pitchVideo(cell: JobDetailHeaderCell) {
        isSelectProfileOrCoverLEtterOrPitchVideo = 2
        tblView.reloadData()
    }
    
    func back(cell: JobDetailHeaderCell) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func message(cell: JobDetailHeaderCell) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APMessageListVC") as? APMessageListVC else {
            return
        }
        vc.jobDetail = jobDetail
//        vc.selectedMessage = messgeItemList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension APJobHolderDetailVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}
