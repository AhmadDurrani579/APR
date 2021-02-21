//
//  APAddExperienceVC.swift
//  APR
//
//  Created by Ahmed Durrani on 15/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

protocol AddExperienceDelegate : class {
    func addExperience(education : ExperienceOfUser)
}

class APAddExperienceVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var numberOfRow : [Int] = []
    var startDate : String?
    var endDate : String?
    
    @IBOutlet weak var vieWOfCard: CardView!
    @IBOutlet weak var btnContinue: UIButton!

    weak var delegate : AddExperienceDelegate?
    var celll = APEducationCell()
    var isComeFromAddEducation : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isComeFromAddEducation == "1" {
            btnContinue.isHidden = true
            vieWOfCard.isHidden = true
        }else {
            btnContinue.isHidden = false
            vieWOfCard.isHidden = false
        }
        
        numberOfRow.append(0)
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()
        tblView.registerCells([APEducationCell.self])
        tblView.delegate = self
        tblView.dataSource = self
        tblView.reloadData()

        // Do any additional setup after loading the view.
    }
    
        @IBAction private func btnAddRow_Pressed(_ sender : UIButton) {
    //        numberOfRow.append(1)
    //        tblView.reloadData()
        }

        @IBAction private func btnContinue_Pressed(_ sender : UIButton) {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APInterestListVC") as? APInterestListVC else {
                return
            }
             if celll.isEmpty(){
                self.showToast("d")
                 self.showAlert(title: "Warning", message: "Fill all fields", controller: self)
                 return
             }
            self.navigationController?.pushViewController(vc, animated: true )
        }
    }

extension APAddExperienceVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: APEducationCell.self, for: indexPath)
        cell.lblCurrentRole.isHidden = false
        cell.btnToggle.isHidden = false
        cell.txtSchool.placeholder = "What's your current title"
        cell.txtDegree.placeholder = "Company Name"
        cell.txtFieldOfStudy.placeholder = "Location"
        cell.txtSchool.delegate = self
        cell.txtDegree.delegate = self
        cell.txtFieldOfStudy.delegate = self
        cell.txtDescription.delegate = self
        celll = cell
        cell.delegate = self
        cell.indexSelect = indexPath
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 363.0
    }
}

extension APAddExperienceVC :  SaveEducationInfoDelegate {
    func saveEducationInfo(cell: APEducationCell, index: IndexPath) {
        let endPoint = AuthEndpoint.experienceAdd(title: cell.txtSchool.text ?? " " , company: cell.txtDegree.text ?? " ", current_role: "1", location: cell.txtFieldOfStudy.text ?? " " , start_date: startDate ?? " ", endDate: endDate ?? " ", descriptionOfExperience: cell.txtDescription.text ?? " ", user_id: userObj!.id!)
                showProgressIndicator(view: self.view)
                NetworkLayer.fetch(endPoint, with: ExperienceApped.self) { (result) in
                    switch result {
                    case .success(let response):
                        if response.success == true {
                            hideProgressIndicator(view: self.view)
                            self.delegate?.addExperience(education: response.data![0])

                            self.showToast(response.message)
                        } else {
                            hideProgressIndicator(view: self.view)
                            self.showToast(response.message)
                        }
                    case .failure(_):
                        hideProgressIndicator(view: self.view)
                        self.showToast("Some thing wrong")
                        break

        //                context?.didFailSignUp(with: error.localizedDescription)
//                        print("Some thing wrong")
                 }

             }
    }
    
    func selectStartDate(cell: APEducationCell, index: IndexPath) {
                 let pick:PresentedViewController = PresentedViewController()
                 pick.titleString = "Select Date"
                 pick.buttonColor = UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0)
                 pick.pickerMode = .date
                 pick.returnDateFormat = dateformat(rawValue: "yyyy-MM-dd")!
                 pick.block = { (date) in
                     cell.btnStartDate.setTitle(date, for: .normal)
                    self.startDate = date
                 }
                 self.present(pick, animated: true, completion: nil)
                

    }
    
    func selectEndDate(cell: APEducationCell, index: IndexPath) {
                 let pick:PresentedViewController = PresentedViewController()
                 pick.titleString = "Select Date"
                 pick.buttonColor = UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0)
                 pick.pickerMode = .date
                 pick.returnDateFormat = dateformat(rawValue: "yyyy-MM-dd")!
                 pick.block = { (date) in
                     cell.btnEndDate.setTitle(date, for: .normal)
                     self.endDate = date

                 }
                 self.present(pick, animated: true, completion: nil)
                


    }
    
    
}

extension APAddExperienceVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        isNumberOfSeatSelect = textField.text
//        print("DidBegin \(textField.text!)")
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        print("DidEnd \(textField.text!)")
//        isNumberOfSeatSelect = textField.text


    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        print("shouldBEgin \(textField.text!)")
//        isNumberOfSeatSelect = textField.text


        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        print("shouldClear \(textField.text!)")
//        isNumberOfSeatSelect = textField.text


        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        print("shouldEndEditing \(textField.text!)")
//        isNumberOfSeatSelect = textField.text


        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("Range Character \(textField.text!)")
//        isNumberOfSeatSelect = textField.text


        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("Text Field Should Return \(textField.text!)")
//        isNumberOfSeatSelect = textField.text

        textField.resignFirstResponder();
        return true;
    }
    
}

extension APAddExperienceVC : DateTimePickerDelegate {
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        
        
    }
}

