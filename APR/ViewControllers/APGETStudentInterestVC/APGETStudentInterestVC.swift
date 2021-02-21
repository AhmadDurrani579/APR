//
//  APGETStudentInterestVC.swift
//  APR
//
//  Created by Ahmed Durrani on 08/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import TagListView

class APGETStudentInterestVC: UIViewController {
    @IBOutlet weak var serviceTag: TagListView!
    @IBOutlet weak var unSelectedTag: TagListView!

    private var interst : [InterestList] = []
    var selectTag : [String] = []
    var alreadInterestList : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = userStudentInfo?.user?.interests!.components(separatedBy: ",")
        for (_ , service) in ((array!.enumerated())) {
            alreadInterestList.append(service)
            serviceTag.addTag(service)
         }
        
        serviceTag.delegate = self

        interestList()
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
        for (_ , intrst) in ((interst.enumerated())) {
            if alreadInterestList.contains(intrst.name!) {
            } else {
                unSelectedTag.addTag(intrst.name!)
            }
        }
        unSelectedTag.delegate = self
    }
}

extension APGETStudentInterestVC : TagListViewDelegate {

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if sender == serviceTag {
            print("Tag pressed: \(title), \(sender.tag)")
            tagView.isSelected = !tagView.isSelected
            if selectTag.contains(title) == true {
                selectTag = selectTag.filter{$0 != title}
                unSelectedTag.addTag(title)
                serviceTag.removeTag(title)
                
            } else {
                selectTag.append(title)
            }
        } else {
            print("Tag pressed: \(title), \(sender.tag)")
            tagView.isSelected = !tagView.isSelected
            if selectTag.contains(title) == true {
                selectTag = selectTag.filter{$0 != title}

            } else {
                selectTag.append(title)
            }
        }
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        if sender == serviceTag {
            
        } else {
            
        }
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

