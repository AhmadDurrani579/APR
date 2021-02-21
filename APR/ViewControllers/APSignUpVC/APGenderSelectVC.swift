//
//  APGenderSelectVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import Toast_Swift
class APGenderSelectVC: UIViewController {

    @IBOutlet weak var coverLetter: UITextView!
    var  jobSelect : [String]?
    var  selectTag : [String]?
    var  skillSelect : [String]?
    var selectLocation : String?
    var radius : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()
        coverLetter.placeholder = "Enter text"
        // Do any additional setup after loading the view.
    }
    

    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        
        let interest = selectTag!.joined(separator: ",")
        let jobSelectss = jobSelect!.joined(separator: ",")
        let skilSelect = skillSelect!.joined(separator: ",")
        if coverLetter.text.count > 100 &&  coverLetter.text.count < 250{
            let persistence = Persistence(with: .user)
             showProgressIndicator(view: self.view)
              let context = (self)
            let authPoint = AuthEndpoint.coverLetter(userId: userObj!.id!, coverLetter: coverLetter.text, interests: interest, jobType: jobSelectss, skill: skilSelect, location: selectLocation ?? DEVICE_ADDRESS, distance: "\(radius!)", latitude: "\(DEVICE_LAT)", longitude: "\(DEVICE_LONG)")
                NetworkLayer.fetch(authPoint, with: LoginResponse.self) {[weak self] (result ) in
                switch result {
                case .success(let response):
                if response.status == 200 {
                    persistence.save(response.data)
                    self?.showToast(response.message)
                    hideProgressIndicator(view: context.view)
                    guard let vc = context.storyboard?.instantiateViewController(withIdentifier: "APPitchVideoVC") as? APPitchVideoVC else {
                        return
                    }
                    context.navigationController?.pushViewController(vc, animated: true )
                } else {
                    context.showToast(response.message!)
                    hideProgressIndicator(view: context.view)
                }
                case .failure(_):
                    hideProgressIndicator(view: context.view)
                    
                    context.showToast("Server Error")
                    break

                }
                }

        } else {
            self.view.makeToast("Min 100 & Max 250 characters", duration: 3.0, position: .center)

//            self.showAlert(title: "Warning", message: "Min 100 & Max 250 characters", controller: self)
        }
    }
    

}

