//
//  APJobFairdAddVC.swift
//  APR
//
//  Created by Ahmed Durrani on 05/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import DatePickerDialog
import GooglePlaces

protocol JobFairAddDelegate : class {
    func addJobFair(obj : JobFairList)
}
class APJobFairdAddVC: UIViewController {
    
    @IBOutlet weak var imgOfJob: UIImageView!
    
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var txtPRiceOfTicket: UITextField!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnStartTime: UIButton!
    @IBOutlet weak var btnEndTime: UIButton!
    @IBOutlet weak var txtDescription: UITextView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    var selectDate : String?
    var selectStartTime : String?
    var selectEndTime : String?
    weak var delegate : JobFairAddDelegate?
    var latitude : Double?
    var longitude : Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtJobTitle.setLeftPaddingPoints(10)
        txtDescription.placeholder = "Enter the job description..."
        txtPRiceOfTicket.setLeftPaddingPoints(10)
        
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(APJobFairdAddVC.imageTappedForDp(img:)))
        imgOfJob.isUserInteractionEnabled = true
        imgOfJob.addGestureRecognizer(tapGestureRecognizerforDp)

        // Do any additional setup after loading the view.
    }
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        photoPicker.pick(allowsEditing: false, pickerSourceType: .CameraAndPhotoLibrary, controller: self) {[weak self] (orignal, edited) in
               self!.imgOfJob.image = orignal
               let cgFloat: CGFloat = self!.imgOfJob.frame.size.width/2.0
               let someFloat = Float(cgFloat)
               WAShareHelper.setViewCornerRadius(self!.imgOfJob, radius: CGFloat(someFloat))
               self!.cover_image = orignal
        }
        
    }

    
    @IBAction func btnStartDate(_ sender: UIButton) {
        let pick:PresentedViewController = PresentedViewController()
        pick.titleString = "Select Date"
        pick.buttonColor = UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0)
        pick.pickerMode = .date
        pick.returnDateFormat = dateformat(rawValue: "yyyy-MM-dd")!
        pick.block = { (date) in
            self.selectDate = date
            self.btnDate.setTitle(date, for: .normal)
        }
        self.present(pick, animated: true, completion: nil)
    }
    
    @IBAction func btnStartTime_Pressed(_ sender: UIButton) {
        
        let pick:PresentedViewController = PresentedViewController()
        pick.titleString = "Select Start Time"
        pick.buttonColor = UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0)
        pick.pickerMode = .time
        pick.returnDateFormat = dateformat(rawValue: "hh:mm aaa")!
        pick.block = { (date) in
            self.selectStartTime = date
            self.btnStartTime.setTitle(date, for: .normal)
        }
        self.present(pick, animated: true, completion: nil)
    }
    
    @IBAction func btnEndTime_Pressed(_ sender: UIButton) {
        
        let pick:PresentedViewController = PresentedViewController()
        pick.titleString = "Select End Time"
        pick.buttonColor = UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0)
        pick.pickerMode = .time
        pick.returnDateFormat = dateformat(rawValue: "hh:mm aaa")!
        pick.block = { (date) in
            self.selectEndTime = date
            self.btnEndTime.setTitle(date, for: .normal)
        }
        self.present(pick, animated: true, completion: nil)
    }
    
    @IBAction func btnSelectAddress(_ sender: UIButton) {
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
    @IBAction func btnSave_Pressed(_ sender: UIButton) {
        let context = (self)
        let companyId = userObj?.company_id!
        guard let data = imgOfJob.image?.jpegData(compressionQuality: 0.5) else {
            return
        }
        showProgressIndicator(view: self.view)
        let endPoint = AuthEndpoint.createJobFair(company_id: companyId!, job_title: txtJobTitle.text ?? " ", start_time: selectStartTime! , end_time:selectEndTime! , price: txtPRiceOfTicket.text ?? " ", start_date: selectDate!, latitude: "\(self.latitude ?? DEVICE_LAT)", longitude: "\(self.longitude ?? DEVICE_LONG)", descriptionOfJob: txtDescription.text!, image: data)
                showProgressIndicator(view: self.view)
                NetworkLayer.fetch(endPoint, with: UserJobFair.self) { (result) in
                    switch result {
                    case .success(let response):
                        if response.success == true {
                            hideProgressIndicator(view: context.view)
                            context.delegate?.addJobFair(obj: response.data!)
                            self.showToast(response.message)
                            self.navigationController?.popViewController(animated: true)

                        } else {
                            hideProgressIndicator(view: context.view)
                            self.showToast(response.message)
                            print("Some thing wrong")
                        }
                    case .failure(_):
                        hideProgressIndicator(view: context.view)
                        break
                        
                    }

             }
    }
}

extension APJobFairdAddVC  : GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//    DEVICE_ADDRESS = place.name!
    self.latitude =  place.coordinate.latitude
    self.longitude =   place.coordinate.longitude
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
