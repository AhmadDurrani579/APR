//
//  APCompanyInterestVC.swift
//  APR
//
//  Created by Ahmed Durrani on 15/06/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import TagListView
protocol SelectInterestDelegate : class {
    func selectTag(interest : [String])
}
class APCompanyInterestVC: UIViewController {
    @IBOutlet weak var serviceTag: TagListView!
    private var interst : [InterestList] = []
    var selectTag : [String] = []
    @IBOutlet var searchBar: UISearchBar!
    var searchActive : Bool = false
    var filteredTableData = [InterestList]()
    var jobTitle : String?
    var location : String?
    var experience  : String?
    var position   : String?
    var employementType   : String?
    var salaryRange   : String?
    var selectDate : String?
    var latitude : Double?
    var longitude : Double?
    var imageOfUseer : UIImage?
    weak var delegate : SelectInterestDelegate?
//    @IBOutlet weak var txtJobTitle: UITextField!
//    @IBOutlet weak var txtLocation: UITextField!
//    @IBOutlet weak var txtExperience: UIButton!
//    @IBOutlet weak var btnPosition: UIButton!
//    @IBOutlet weak var btnEmployment: UIButton!
//    @IBOutlet weak var txtSalary: UITextField!
//    @IBOutlet weak var txtDescription: UITextField!
//    @IBOutlet weak var btnStartDate: UIButton!
    var isComeFromFilter  = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.searchBarStyle = UISearchBar.Style.prominent
        self.searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        let textField = self.searchBar.value(forKey: "searchField") as? UITextField
        textField?.backgroundColor = UIColor.white
        self.searchBar.barTintColor = UIColor.white

        interestList()
        // Do any additional setup after loading the view.
    }
    
    func interestList() {
        let endPoint = AuthEndpoint.interestList
         showProgressIndicator(view: self.view)
        let context = (self)

          NetworkLayer.fetch(endPoint, with: Interest.self) { (result) in
          switch result {
            case .success(let response):
                        if response.success == true {
                            hideProgressIndicator(view: self.view)
                            self.showToast(response.message)
                            context.interst = response.data ??  []
                            context.showTagtList()
                        } else {
                            hideProgressIndicator(view: self.view)
                            self.showToast(response.message)
                        }
                    case .failure(_):
                        hideProgressIndicator(view: self.view)
                        self.showToast("Some thing wrong")
                        break
                 }

             }
    }
    
    func showTagtList() {
        serviceTag.removeAllTags()
        for (_ , intrst) in ((interst.enumerated())) {
            if selectTag.contains(intrst.name!) == true {
                let tagView = serviceTag.addTag(intrst.name!)
                tagView.tagBackgroundColor = UIColor(red: 33/255.0, green: 195/255.0, blue: 240/255.0, alpha: 1.0)
                tagView.textColor = UIColor.white
                
            } else {
                serviceTag.addTag(intrst.name!)
            }

        }
        serviceTag.delegate = self
    }

    @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
        if selectTag.count == 0 {
            self.showToast("Please select tag")
        } else {
            if isComeFromFilter == true {
                delegate?.selectTag(interest: selectTag)
                self.navigationController?.popViewController(animated: true)
            } else {
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APJobSkillVC") as? APJobSkillVC else {
                    return
                }
                vc.jobTitle = jobTitle
                vc.location = location
                vc.experience = experience
                vc.position =   position
                vc.employementType =   employementType
                vc.salaryRange =   salaryRange
                vc.selectDate = selectDate
                vc.latitude = latitude
                vc.longitude = longitude
                vc.imageOfUseer = imageOfUseer
                vc.selectedTags = selectTag
                self.navigationController?.pushViewController(vc, animated: true )
            }
        }
    }
}

extension APCompanyInterestVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender.tag)")
        tagView.isSelected = !tagView.isSelected
        if selectTag.contains(title) == true {
            selectTag = selectTag.filter{$0 != title}
        } else {
            selectTag.append(title)
        }
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchActive = false;
        self.searchBar.endEditing(true)
    }
}

extension APCompanyInterestVC  : UISearchBarDelegate {
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        serviceTag.removeAllTags()
        searchActive = false
        serviceTag.delegate = self
        showTagtList()
        self.searchBar.endEditing(true)
        self.searchBar.showsCancelButton = false

    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let firstSubview = searchBar.subviews.first else { return }
        firstSubview.subviews.forEach {
            ($0 as? UITextField)?.clearButtonMode = .never
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            showTagtList()
            return
        }
        serviceTag.removeAllTags()
        self.searchBar.showsCancelButton = true
        searchActive = true
        filteredTableData  = interst.filter{ ($0.name?.contains(searchText))!}
        for (_ , intrst) in ((filteredTableData.enumerated())) {
            serviceTag.addTag(intrst.name!)
        }
        serviceTag.delegate = self
    }


}

