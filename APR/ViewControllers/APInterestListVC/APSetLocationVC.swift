//
//  APSetLocationVC.swift
//  APR
//
//  Created by Ahmed Durrani on 15/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import RangeSeekSlider
import GoogleMaps
import GooglePlaces

class APSetLocationVC: UIViewController {
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet var txtLocation : UITextField!
    var radius : Int?
    var selectTag : [String] = []
    var skillSelect : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()
        rangeSlider.delegate = self
        radius = 0
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction private func btnDone_Pressed(_ sender : UIButton) {
        if txtLocation.text!.count > 0 {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobTypeSelectVC") as? APJobTypeSelectVC else {
                return
            }
            vc.selectTag = selectTag
            vc.skillSelect = skillSelect
            vc.selectLocation = txtLocation.text
            vc.radius = radius
            self.navigationController?.pushViewController(vc, animated: true )
            
        } else {
            self.showAlert(title: "Warning", message: "Please enter the location ", controller: self)
            
            //            self.showToast("Please enter the location ")
        }
        
    }
    
    @IBAction private func btnSelectLocation_Pressed(_ sender : UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
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

extension APSetLocationVC: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        radius = Int(maxValue)
        print(radius)
    }
    func didStartTouches(in slider: RangeSeekSlider) {
        //        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        //        print("did end touches")
    }
}

extension APSetLocationVC  : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        txtLocation.text = place.name
        DEVICE_ADDRESS = place.name!
        DEVICE_LAT =  place.coordinate.latitude
        DEVICE_LONG =   place.coordinate.longitude
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
