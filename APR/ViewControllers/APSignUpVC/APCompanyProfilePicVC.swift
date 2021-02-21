//
//  APCompanyProfilePicVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APCompanyProfilePicVC: UIViewController {
    var email : String?
    var password : String?
    var companyName : String?
    @IBOutlet weak var imageOfUser: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    @IBOutlet weak var viewOfProfilePic: CardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(APCompanyProfilePicVC.imageTappedForDp(img:)))
        imageOfUser.isUserInteractionEnabled = true
        imageOfUser.addGestureRecognizer(tapGestureRecognizerforDp)

    }
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) { (orignal, edited) in
            
            self.imageOfUser.image = orignal
            self.imageOfUser.contentMode = .scaleAspectFill
            self.cover_image = orignal
        }
    }

    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCompanyLocation") as? APCompanyLocation else {
            return
        }
        vc.email = email
        vc.password = password
        vc.companyName = companyName!
        vc.cover_image = cover_image
        self.navigationController?.pushViewController(vc, animated: true )

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
