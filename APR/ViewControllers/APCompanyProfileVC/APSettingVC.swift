//
//  APSettingVC.swift
//  APR
//
//  Created by Ahmed Durrani on 12/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class APSettingVC: UIViewController {
    
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var btnEnableOrDisbale: UIButton!
    @IBOutlet weak var lblEnableOrDisable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblLocation.text = userStudentInfo?.user?.location ?? " "
        if userObj?.notifications == "1" {
            btnEnableOrDisbale.isSelected = true
        } else {
            btnEnableOrDisbale.isSelected = false
        }
    }
    
    func changeNotification(isNotificationOnOrOff : String) {
        let userId = userObj?.id
        let companyId = userObj?.company_id
        let endPoint = AuthEndpoint.updateNotification(userId: userId!, isNotificationOnOroff: isNotificationOnOrOff, companyId: companyId!)
        let context = (self)
        let persistence = Persistence(with: .user)
        
        NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
            switch result {
            case .success(let response):
            if response.status == 200 {
                persistence.save(response.data)
                hideProgressIndicator(view: context.view)
                context.showToast(response.message)
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
    }
   
    @IBAction func btnEnableOrDisableNotificatio(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected == true {
            changeNotification(isNotificationOnOrOff: "1")
        } else {
            changeNotification(isNotificationOnOrOff: "0")
        }
    }

    @IBAction func btnChangePassword(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APChangePasswordVC") as? APChangePasswordVC else {
               return
           }
           self.navigationController?.pushViewController(vc, animated: true )

    }
        
    
    @IBAction func btnChangeLocation(_ sender: UIButton) {
                let autocompleteController = GMSAutocompleteViewController()
                autocompleteController.delegate = self

                // Specify the place data types to return.
        //        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        //          UInt(GMSPlaceField.placeID.rawValue))!
        //        autocompleteController.placeFields = fields
                
                let fields: GMSPlaceField = GMSPlaceField(rawValue:UInt(GMSPlaceField.name.rawValue) |
                            UInt(GMSPlaceField.placeID.rawValue) |
                            UInt(GMSPlaceField.coordinate.rawValue) |
                            GMSPlaceField.addressComponents.rawValue |
                            GMSPlaceField.formattedAddress.rawValue)!
                autocompleteController.placeFields = fields

                // Specify a filter.
                let filter = GMSAutocompleteFilter()
                filter.type = .address
                autocompleteController.autocompleteFilter = filter

                // Display the autocomplete view controller.
                present(autocompleteController, animated: true, completion: nil)

    }
}

extension APSettingVC : GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    lblLocation.text = place.name
    userStudentInfo?.user?.latitude =  String(place.coordinate.latitude)
    userStudentInfo?.user?.longitude =  String(place.coordinate.longitude)
    userStudentInfo?.user?.location = place.name
    let userId = userObj?.id

    let endPoint = AuthEndpoint.updateLocation(userId: userId!, location: place.name!, latitude: "\(place.coordinate.latitude)", longitude: "\(place.coordinate.longitude)")
    let context = (self)
    NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
        switch result {
        case .success(let response):
        if response.status == 200 {
            context.showToast(response.message)
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
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

}

