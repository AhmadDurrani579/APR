//
//  APCompanyNameVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APCompanyNameVC: UIViewController {
    @IBOutlet var txtName : UITextField!
    var presenter: RegistrationPresenter?
    var email : String?
    var password : String?
    @IBOutlet weak var imageOfUser: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
//    @IBOutlet weak var viewOfProfilePic: CardView!
    var imageSelected: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.setLeftPaddingPoints(15.0)
        presenter = RegistrationPresenter(delegate: self)
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(APCompanyProfilePicVC.imageTappedForDp(img:)))
        imageOfUser.isUserInteractionEnabled = true
        imageOfUser.addGestureRecognizer(tapGestureRecognizerforDp)

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

    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        presenter?.NameInfo(name : txtName.text! , imageSelect : imageSelected)
    }
}

extension APCompanyNameVC  : RegistrationDelegate {
    func registrationDidFailed(message: String) {
//        self.showToast(message)
        self.showAlert(title: "Warning", message: message, controller: self)

    }
    func registrationDidSucceed(){
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCompanyLocation") as? APCompanyLocation else {
            return
        }
        vc.email = email
        vc.password = password
        vc.companyName = txtName.text!
        vc.cover_image = cover_image

        self.navigationController?.pushViewController(vc, animated: true )
    }
}
