//
//  APAddJobVC.swift
//  APR
//
//  Created by Ahmed Durrani on 05/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import DatePickerDialog
import McPicker
import ActionSheetPicker_3_0
import GooglePlaces

protocol  AddJobDelegate : class {
    func addJobDelegate(job : CompanyJobList)
}
class APAddJobVC: UIViewController {
    
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtExperience: UIButton!
    @IBOutlet weak var btnPosition: UIButton!
    @IBOutlet weak var btnEmployment: UIButton!
    @IBOutlet weak var txtSalary: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var btnStartDate: UIButton!
    
    @IBOutlet weak var imgOfJob: UIImageView!
    let photoPicker = PhotoPicker()
    var cover_image: UIImage?
    weak var delegate : AddJobDelegate?
    
    let arrayOfExperience = ["1 year" , "2 years" , "3 years" , "4 years" , "5 years" , "6 years", "7 years", "8 years", "9 years"]
    let arrayOfPosition = ["Fresh" , "Junior" , "Middle Level" , "Senior"]
    let arrayOfEmployment = ["Internship" , "Full Time Job" , "Part Time Job"]
    var selectDate : String?
    var latitude : Double?
    var longitude : Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(APAddJobVC.imageTappedForDp(img:)))
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
    
    @IBAction func btnPosition(_ sender: UIButton) {
        McPicker.show(data: [arrayOfPosition]) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self!.btnPosition.setTitle(name  , for: .normal)
            }
        }
    }
    
    @IBAction func btnExperience_Pressed(_ sender: UIButton) {
        McPicker.show(data: [arrayOfExperience]) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self!.txtExperience.setTitle(name  , for: .normal)
            }
        }
    }
    
    @IBAction func btnEmployment_Pressed(_ sender: UIButton) {
        McPicker.show(data: [arrayOfEmployment]) {  [weak self] (selections: [Int : String]) -> Void in
            if let name = selections[0] {
                self!.btnEmployment.setTitle(name  , for: .normal)
            }
        }
    }
    
    @IBAction func btnStartDate_Pressed(_ sender: UIButton) {
        datePickerTapped()
    }
    
    func datePickerTapped() {
        
        let pick:PresentedViewController = PresentedViewController()
        pick.titleString = "Select Date"
        pick.buttonColor = UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0)
        pick.pickerMode = .date
        pick.returnDateFormat = dateformat(rawValue: "yyyy-MM-dd")!
        pick.block = { (date) in
            self.selectDate = date
            self.btnStartDate.setTitle(date, for: .normal)
        }
        self.present(pick, animated: true, completion: nil)
        
        //        let currentDate = Date()
        //        var dateComponents = DateComponents()
        //        dateComponents.month = 1970
        //        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        //
        //        let datePicker = DatePickerDialog(textColor: .black,
        //                                          buttonColor: .black,
        //                                          font: UIFont.boldSystemFont(ofSize: 17),
        //                                          showCancelButton: true)
        //        datePicker.show("DatePickerDialog",
        //                        doneButtonTitle: "Done",
        //                        cancelButtonTitle: "Cancel",
        //                        minimumDate: threeMonthAgo,
        //                        maximumDate: currentDate,
        //                        datePickerMode: .date) { (date) in
        //                            if let dt = date {
        ////                                self.isDateSelect = true
        //                                let formatter = DateFormatter()
        //                                formatter.dateFormat = "yyyy-MM-dd"
        //                                let dateValue = formatter.string(from: dt)
        //                                self.selectDate = dateValue
        //                                self.btnStartDate.setTitle(dateValue, for: .normal)
        //                }
        //            }
    }
    
    
    @IBAction private func btnNo_Pressed(_ sender : UIButton) {
        self.navigationController?.popViewController(animated: true)
//        self.dismiss(animated: true) {
//
//        }
    }
    
    @IBAction func btnAddAddress_Pressed(_ sender: UIButton) {
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
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCompanyInterestVC") as? APCompanyInterestVC else {
            return
        }
        vc.jobTitle = txtJobTitle.text ?? " "
        vc.location = txtLocation.text ?? " "
        vc.experience = txtExperience.titleLabel?.text ?? " "
        vc.position =   btnPosition.titleLabel!.text ?? " "
        vc.employementType =   btnEmployment.titleLabel!.text ?? " "
        vc.salaryRange =   txtSalary.text ?? " "
        vc.selectDate = selectDate
        vc.latitude = latitude
        vc.longitude = longitude
        vc.imageOfUseer = imgOfJob.image
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let companyId  = userObj?.company_id
//        let positionOfJob = btnPosition.titleLabel?.text!
//        let experineRequired = txtExperience.titleLabel?.text!
//        let employment = btnEmployment.titleLabel?.text!
//        guard let data = imgOfJob.image?.jpegData(compressionQuality: 0.5) else {
//            return
//        }
//        let endPoint = AuthEndpoint.createJob(company_id: companyId! , job_title: txtJobTitle.text ??  " " , position: positionOfJob ?? " " , location: txtLocation.text ?? " ", experience: experineRequired ?? " ", employment_type: employment ?? " ", start_date: selectDate ?? " ", latitude: "\(latitude ?? DEVICE_LAT)", longitude: "\(longitude ?? DEVICE_LONG)", salary: txtSalary.text ?? " ", descriptionOfJob: txtDescription.text ?? " ", image: data)
//        showProgressIndicator(view: self.view)
//        let context = (self)
//        NetworkLayer.fetch(endPoint, with: AddJob.self) { (result) in
//            switch result {
//            case .success(let response):
//                if response.success == true {
//                    hideProgressIndicator(view: self.view)
//                    context.showToast(response.message)
//                    context.delegate?.addJobDelegate(job: response.data!)
//                    self.dismiss(animated: true) {
//                    }
//                } else {
//                    hideProgressIndicator(view: self.view)
//                    context.showToast(response.message)
//                }
//            case .failure(_):
//                hideProgressIndicator(view: self.view)
//                context.showToast("Some thing wrong")
//                break
//            }
//        }
    }
    
}

extension APAddJobVC  : GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        txtLocation.text = place.name
        latitude =  place.coordinate.latitude
        longitude =   place.coordinate.longitude
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
