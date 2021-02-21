//
//  APJobListVC.swift
//  APR
//
//  Created by Ahmed Durrani on 20/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import Koloda
import TagListView
import RangeSeekSlider
import GoogleMaps
import GooglePlaces


class APJobListVC: UIViewController {
    @IBOutlet weak var kolodaView: KolodaView!
    private var userList : [JobList] = []
    
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
    @IBOutlet weak var btnChoseIntetest: UIButton!
    
    @IBOutlet weak var btnClearFilterBtn: UIButton!
    @IBOutlet weak var txtSkillSelect: UITextField!
    @IBOutlet weak var btnJobType: UIButton!
    var latitude : Double?
    var longitude : Double?
    var radius : Int?
    //    let interest = selectedTags!.joined(separator: ",")
    var interest : [String] = []
    var skillSelect : [String] = []
    var jobTypeSelect : [String] = []
    
    @IBOutlet weak var viewOfFilter: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnClearFilterBtn.isHidden = true
        rangeSlider.delegate = self
        radius = 100
        getAllUserAround()
        // Do any additional setup after loading the view.
    }
    
    func getAllUserAround() {
        let companyId = userObj?.company_id
        let endPoint = AuthEndpoint.getUsersArround(distance: "50", latitude: "\(34.34343)", longitude: "\(72.34343)", interests: "Hiking" , company_id: "43")
        showProgressIndicator(view: self.view)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: Job.self) { (result) in
            switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    self.showToast(response.message)
                    context.userList = response.data ??  []
                    context.kolodaView.dataSource = self
                    context.kolodaView.delegate = self
                    context.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                    
                } else {
                    hideProgressIndicator(view: self.view)
                    context.userList = []
                    context.kolodaView.dataSource = self
                    context.kolodaView.delegate = self
                    context.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                    context.kolodaView.reloadData()
                    self.showToast(response.message)
                }
            case .failure(let _):
                hideProgressIndicator(view: self.view)
                self.showToast("Some thing wrong")
                break
            }
        }
    }
    
    @IBAction func btnCross(_ sender: UIButton) {
        self.viewOfFilter.isHidden = true
    }
    
    @IBAction func btnFilter_Pressed(_ sender: UIButton) {
        self.viewOfFilter.isHidden = false
    }
    
    func userInterOrNot(obj : JobList , isUserInterestOrNot : String) {
        let companyId = userObj?.company_id
        let userId = obj.user_id
        let endPoint = AuthEndpoint.interestingOrNot(companyId: companyId!, userId: userId!, interest: isUserInterestOrNot)
        
        //         showProgressIndicator(view: self.view)
        //        let context = (self)
        NetworkLayer.fetch(endPoint, with: Job.self) { (result) in
            switch result {
            case .success(let response):
                if response.success == true {
//                    self.getAllUserAround()
                } else {
                    hideProgressIndicator(view: self.view)
                    self.showToast(response.message)
                }
            case .failure(_):
                hideProgressIndicator(view: self.view)
//                self.showToast("Some thing wrong")
                break
            }
            
        }
    }
    @IBAction func btnChoseInterest(_ sender: UIButton) {
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "APCompanyInterestVC") as? APCompanyInterestVC
            else {
                return
        }
        vc.isComeFromFilter = true
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnJobType_Pressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard  let vc = storyboard.instantiateViewController(withIdentifier: "APJobTypeSelectVC") as? APJobTypeSelectVC
            else {
                return
        }
        vc.isComeFromFilter = true
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnChoseSkill(_ sender : UIButton) {
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobSkillVC") as? APJobSkillVC
            else {
                return
        }
        vc.isComeFromFilter = true
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnClearFilter_Pressed(_ sender : UIButton) {
        self.userList =    []
        self.getAllUserAround()
        self.btnClearFilterBtn.isHidden = true
        self.viewOfFilter.isHidden = true
    }
    
    @IBAction func btnApplyFilter_Pressed(_ sender : UIButton) {
      
        if txtLocation.text!.count <= 0 {
            self.showToast("Select Location")
            return
        }
        if self.interest.count <= 0  {
            self.showToast("Select Interest")
            return
        }
        if self.skillSelect.count <= 0  {
            self.showToast("Select Skills")
            return
        }
        if self.jobTypeSelect.count <= 0  {
            self.showToast("Select Job Type")
            return
        }
        
        let interest = self.interest.joined(separator: ",")
        let skilSelect = skillSelect.joined(separator: ",")
        let jobSelect = jobTypeSelect.joined(separator: ",")
        let endPoint = AuthEndpoint.searchFilter(distance: "\(radius!)", location: txtLocation.text ?? DEVICE_ADDRESS , jobType: jobSelect  , latitude: "\(self.latitude!)", longitude: "\(self.longitude!)",  skills: skilSelect, interests: interest)
        showProgressIndicator(view: self.view)
        let context = (self)

        NetworkLayer.fetch(endPoint, with: Job.self) { (result) in
            switch result {
            case .success(let response):
                if response.success == true {
                    hideProgressIndicator(view: self.view)
                    context.userList = response.data ??  []
                    context.kolodaView.dataSource = self
                    context.kolodaView.delegate = self
                    context.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                    context.viewOfFilter.isHidden = true
                    //                    context?.didSignUp(with: response.message)
                } else {
                    
                    self.btnClearFilterBtn.isHidden = false
                    context.viewOfFilter.isHidden = true
                    self.showToast(response.message)
                    hideProgressIndicator(view: self.view)
                    context.userList =    []
                    context.kolodaView.dataSource = self
                    context.kolodaView.delegate = self
                    context.kolodaView.reloadData()
//                    context.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
//                    context.viewOfFilter.isHidden = false

                }
            case .failure(let error):
                hideProgressIndicator(view: self.view)
                break
            }
            
        }
    }
 }
    //MARK: KolodaViewDelegate
    extension APJobListVC: KolodaViewDelegate {
        
        func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
            kolodaView.resetCurrentCardIndex()
        }
        
        func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobHolderDetailVC") as? APJobHolderDetailVC else {
                return
            }
            vc.jobDetail = userList[index]
            self.navigationController?.pushViewController(vc, animated: true )
        }
        func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
            return true
        }
        
        func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
            return false
        }
        
        func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
            return true
        }
        
        //    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        //        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        //        animation?.springBounciness = frameAnimationSpringBounciness
        //        animation?.springSpeed = frameAnimationSpringSpeed
        //        return animation
        //    }
    }
    
    // MARK: KolodaViewDataSource
    extension APJobListVC: KolodaViewDataSource {
        
        func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
            return .default
        }
        func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
            return userList.count
        }
        
        func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
            let cell = Bundle.main.loadNibNamed("SwipeCell", owner: self, options: nil)?[0] as? SwipeCell
            cell?.lblUserNam.text = userList[index].name
            cell?.lblAddress.text = userList[index].location
            cell?.lblNumberOfExperience.text = "4 Years"
            cell?.lblExperience.text = userList[index].descriptionOfUser
            //        print("print" , userList[index].picture)
            guard let img = userList[index].picture else {
                return cell!
            }
            WAShareHelper.loadImage(urlstring:img , imageView: ((cell?.imgOfUser!)!), placeHolder: "profile")
            //        cell?.imgOfUser.setImage(with: img, placeholder: UIImage(named: "upload_photo"))
            let cgFloat: CGFloat = (cell?.imgOfUser.frame.size.width)!/2.0
            let someFloat = Float(cgFloat)
            GeneralUtilities.setViewCornerRadius(cell!.imgOfUser , radius: CGFloat(someFloat))
            cell?.lblJobTitle.text = userList[index].experince![0].title
            cell?.lblCompanyName.text = userList[index].experince![0].company
            cell?.lblUniName.text = userList[index].education![0].school
            let degree = userList[index].education![0].degree
            let field = userList[index].education![0].field
            cell?.lblDegreeProgram.text = "\(degree!) , \(field!)"
            let start_date = userList[index].education![0].start_date
            let end_date = userList[index].education![0].end_date
            cell?.lblDateFinish.text = "\(start_date!) - \(end_date!)"
            
            let skill = userList[index].skills!.components(separatedBy: ",")
            for (_ , service) in ((skill.enumerated())) {
                cell?.skillTagList.addTag(service)
            }
            cell?.skillTagList.delegate = self
            
            let array = userList[index].interests!.components(separatedBy: ",")
            for (_ , service) in ((array.enumerated())) {
                cell?.tagList.addTag(service)
            }
            cell?.tagList.delegate = self
            return cell!
        }
        
        func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
            return Bundle.main.loadNibNamed("SwipeCell", owner: self, options: nil)?[0] as? SwipeCell
        }
        
        func koloda(_ koloda: KolodaView, shouldSwipeCardAt index: Int, in direction: SwipeResultDirection) -> Bool {
            return true
        }
        
        func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection)
        {
            let obj = userList[index]
            if direction == .left {
//                DispatchQueue.global().async { [weak self] in
                    self.userInterOrNot(obj: obj, isUserInterestOrNot: "0")
//                }
            } else {
                self.userInterOrNot(obj: obj, isUserInterestOrNot: "1")
            }
            
        }
        
        
    }
    extension APJobListVC : TagListViewDelegate {
        
        func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
            print("Tag pressed: \(title), \(sender)")
            tagView.isSelected = !tagView.isSelected
        }
        
        func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
            print("Tag Remove pressed: \(title), \(sender)")
            sender.removeTagView(tagView)
        }
    }
    
    extension APJobListVC : UITextFieldDelegate {
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == txtLocation {
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
    }
    
    extension APJobListVC: RangeSeekSliderDelegate {
        
        func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
            radius = Int(maxValue)
            print(radius)
        }
        
        func didStartTouches(in slider: RangeSeekSlider) {
        }
        
        func didEndTouches(in slider: RangeSeekSlider) {
            //        print("did end touches")
        }
    }
    
    extension APJobListVC : SelectInterestDelegate {
        func selectTag(interest : [String]) {
            self.interest = interest
            let interestsss = self.interest.joined(separator: ",")
            self.btnChoseIntetest.setTitle(interestsss, for: .normal)

        }
    }
    
    extension APJobListVC : SelectSkillDelegatess {
        func selectSkills(interest: [String]) {
            self.skillSelect = interest
            let skill = self.skillSelect.joined(separator: ",")
            self.txtSkillSelect.text = skill
        }
    }
    
    extension APJobListVC : JobSelectFilterdelegate {
        func jobTypeSelect(selectJob: [String]) {
            self.jobTypeSelect = selectJob
            let jobType = self.jobTypeSelect.joined(separator: ",")
            self.btnJobType.setTitle(jobType , for: .normal)

        }
    }
    extension APJobListVC  : GMSAutocompleteViewControllerDelegate {
        
        // Handle the user's selection.
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            txtLocation.text = place.name
            DEVICE_ADDRESS = place.name!
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
