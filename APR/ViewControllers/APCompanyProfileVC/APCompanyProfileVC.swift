//
//  APCompanyProfileVC.swift
//  APR
//
//  Created by Ahmed Durrani on 03/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APCompanyProfileVC: UIViewController {
    @IBOutlet weak var imgOfUser: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblUserNma: UILabel!
    let photo = PhotoPicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let persistence = Persistence(with: .user)
//        userObj  = persistence.load()
        lblUserNma.text = userObj?.company_name ?? "Not Given"
        lblEmail.text = userObj?.email
        
        guard let img = userObj?.picture else {
            return
        }
        imgOfUser.setImage(with: img, placeholder: UIImage(named: "jobFair"))
        let cgFloat: CGFloat = (imgOfUser.frame.size.width)/2.0
        let someFloat = Float(cgFloat)
        GeneralUtilities.setViewCornerRadius(imgOfUser , radius: CGFloat(someFloat))

    }
    
    
    @IBAction func btnAddJob_Pressed(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCurrentJobListVC") as? APCurrentJobListVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true )

    }
    @IBAction func btnSetting_Pressed(_ sender: UIButton) {
         guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APSettingVC") as? APSettingVC else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true )

    }
    
    @IBAction private func btnChooseImage_Pressed(_ sender : UIButton) {
        photo.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) {[weak self] (orignal, edited) in
            self!.imgOfUser.image = orignal
            let cgFloat: CGFloat = (self!.imgOfUser.frame.size.width)/2.0
            let someFloat = Float(cgFloat)
            GeneralUtilities.setViewCornerRadius(self!.imgOfUser , radius: CGFloat(someFloat))
            guard let data = self!.imgOfUser.image?.jpegData(compressionQuality: 0.5) else {
                return
            }
            let userId = userObj?.id
            let compnaID = userObj?.company_id
            showProgressIndicator(view: self!.view)
            let endPoint = AuthEndpoint.updateProfileImage(userId: userId!, image: data, companyId: compnaID!)
            let context = (self)
            let persistence = Persistence(with: .user)
            NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
                switch result {
                case .success(let response):
                if response.status == 200 {
                    persistence.save(response.data)
                    hideProgressIndicator(view: context!.view)
                    context!.showToast(response.message)
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
    
    @IBAction private func btnLogout_Pressed(_ sender : UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        Persistence.init(with: .user).delete()
        UIApplication.shared.keyWindow?.rootViewController = vc

    }
}
