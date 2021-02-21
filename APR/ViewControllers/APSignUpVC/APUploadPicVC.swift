//
//  APUploadPicVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APUploadPicVC: UIViewController {

    @IBOutlet weak var imageOfUser: UIImageView!
    @IBOutlet weak var viewOfProfilePic: CardView!
//    var selectGender : String?
    var email : String?
    var password : String?
    var accountType : String?
    var userName : String?
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    var imageSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(APUploadPicVC.imageTappedForDp(img:)))
        imageOfUser.isUserInteractionEnabled = true
        imageOfUser.addGestureRecognizer(tapGestureRecognizerforDp)

        WAShareHelper.setBorderAndCornerRadius(layer: viewOfProfilePic.layer, width: 1.0, radius: 5.0, color: UIColor.lightGray)
        WAShareHelper.setBorderAndCornerRadius(layer: imageOfUser.layer, width: 1.0, radius: 5.0, color: UIColor.clear)

        // Do any additional setup after loading the view.
    }
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            self.imageOfUser.image = orignal
            self.imageOfUser.contentMode = .scaleAspectFill
            self.cover_image = orignal
            self.imageSelected = true
        }
    }

    
    @IBAction func btnUploadPic(_ sender: UIButton) {

        if !imageSelected {
            self.showToast(KIMAGeSELECT)
            return
        }
        let persistence = Persistence(with: .user)
        let context = (self)
        guard let data = imageOfUser.image?.jpegData(compressionQuality: 0.5) else {
            return
        }
        let endPoint = AuthEndpoint.signUp(name: userName! , type: accountType! , device: "iOS", device_id: "dsasa2123123", password: password! , email: email! , image: data)
        showProgressIndicator(view: self.view)
        NetworkLayer.fetch(endPoint, with: LoginResponse.self) { (result) in
            switch result {
            case .success(let response):
                if response.success == true {
                    persistence.save(response.data)
                    hideProgressIndicator(view: context.view)
                    self.showToast(response.message)
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APAddEducationInfoVC") as? APAddEducationInfoVC else {
                        return
                    }
                    self.navigationController?.pushViewController(vc, animated: true )

//                    context?.didSignUp(with: response.message)
                } else {
                    hideProgressIndicator(view: context.view)

                    self.showToast(response.message)
//                    context?.didFailSignUp(with: response.message)
                    print("Some thing wrong")

                }
                case .failure(_):
                    hideProgressIndicator(view: context.view)
                break
         }

     }
    }
//    }
    
  
}
