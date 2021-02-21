//
//  APStudentSettingVC.swift
//  APR
//
//  Created by Ahmed Durrani on 08/03/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APStudentSettingVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    let arrayOfProfile = ["Settings" , "Education" , "Experience" , "Interests" , "Skills" , "QR Code" , "Log Out"]
    let photo = PhotoPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.registerCells([StudentProfilecell.self , StudentSettingProfilecell.self])
        tblView.reloadData()
    }
}

extension APStudentSettingVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return arrayOfProfile.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: StudentProfilecell.self, for: indexPath)
            cell.lblName.text = userObj?.name
            cell.lblEmail.text = userObj?.email
            cell.delegate = self
            guard let img = userObj?.picture else {
                return cell
            }
            
            WAShareHelper.loadImage(urlstring:img , imageView: ((cell.userProfile!)), placeHolder: "add")
//            cell.userProfile.setImage(with: img, placeholder: UIImage(named: "add"))
            let cgFloat: CGFloat = (cell.userProfile.frame.size.width)/2.0
            let someFloat = Float(cgFloat)
            GeneralUtilities.setViewCornerRadius(cell.userProfile , radius: CGFloat(someFloat))
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(with: StudentSettingProfilecell.self, for: indexPath)
            cell.lblProfileSetting.text = arrayOfProfile[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110.0
        } else {
            return 80
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "APSettingVC") as? APSettingVC else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)

        }
        else if indexPath.row == 1 {
            guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "APStudentEducationVC") as? APStudentEducationVC else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "APStudentExperienceVC") as? APStudentExperienceVC else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
            else if indexPath.row == 3 {
                guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "APGETStudentInterestVC") as? APGETStudentInterestVC else {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 4 {
                guard   let vc = self.storyboard?.instantiateViewController(withIdentifier: "APAddSkillVC") as? APAddSkillVC else {
                    return
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        else if indexPath.row == 6 {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
            Persistence.init(with: .user).delete()
            UIApplication.shared.keyWindow?.rootViewController = vc
        }
    }
    
}

extension APStudentSettingVC : AddProfilePhotoDelegate {
//    func profile(cell: StudentProfilecell) {
//        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APUserProfileVC") as? APUserProfileVC else {
//            return
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
      func addPhoto(cell : StudentProfilecell) {
            photo.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) {[weak self] (orignal, edited) in
                cell.userProfile.image = orignal
                let cgFloat: CGFloat = (cell.userProfile.frame.size.width)/2.0
                let someFloat = Float(cgFloat)
                GeneralUtilities.setViewCornerRadius(cell.userProfile , radius: CGFloat(someFloat))
                guard let data = cell.userProfile.image?.jpegData(compressionQuality: 0.5) else {
                    return
                }
                let userId = userObj?.id
                showProgressIndicator(view: self!.view)
                let endPoint = AuthEndpoint.studentProfileImage(userId: userId!, image: data)
                let context = (self)
                let persistence = Persistence(with: .user)
                NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
                    switch result {
                    case .success(let response):
                    if response.status == 200 {
                        persistence.save(response.data)
                        hideProgressIndicator(view: context!.view)
                        context!.showToast(response.message)
                        context!.tblView.reloadData()
                    } else {
                        context!.showToast(response.message!)
                        hideProgressIndicator(view: context!.view)
                    }
                    case .failure(_):
                        hideProgressIndicator(view: context!.view)
                        context!.showToast("Server Error")
                        break
                
                    }
                    }
        }
      }
}
