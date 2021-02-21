//
//  APAddEducationInfoVC.swift
//  APR
//
//  Created by Ahmed Durrani on 15/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

protocol AddEducationDelegate : class {
    func addEducation(education : EducationOfUser)
}
class APAddEducationInfoVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var numberOfRow : [Int] = []
    var startDate : String?
    var endDate : String?
    var startDatePressed: Bool = false
    weak var delegate : AddEducationDelegate?
    var celll = APEducationCell()
    @IBOutlet weak var vieWOfCard: CardView!
    @IBOutlet weak var btnContinue: UIButton!
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
        
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()
        
        numberOfRow.append(0)
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
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APAddExperienceVC") as? APAddExperienceVC else {
            return
        }
        if celll.isEmpty(){
            self.showAlert(title: "Warning", message: "Fill all fields", controller: self)
            return
        }
       self.navigationController?.pushViewController(vc, animated: true )
        
    }
    
    
}

extension APAddEducationInfoVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: APEducationCell.self, for: indexPath)
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

extension APAddEducationInfoVC :  SaveEducationInfoDelegate {
    func saveEducationInfo(cell: APEducationCell, index: IndexPath) {
        if celll.isEmpty(){
            self.showAlert(title: "Warning", message: "Fill all fields", controller: self)
            return
        }
        let endPoint = AuthEndpoint.educationAdd(school: cell.txtSchool.text ?? " ", user_id: userObj!.id! , degree: cell.txtDegree.text ?? " ", field: cell.txtFieldOfStudy.text ?? " ", start_date: startDate ?? " " , endDate: endDate ?? " " , descriptionOfUni: cell.txtDescription.text ?? " ")
        showProgressIndicator(view: self.view)
        
        NetworkLayer.fetch(endPoint, with: EducationApped.self) { (result) in
            switch result {
            case .success(let response):
                if response.success == true {
                    self.showToast(response.message)
                    self.delegate?.addEducation(education: response.data![0])
                    hideProgressIndicator(view: self.view)
                } else {
                    hideProgressIndicator(view: self.view)
                }
            case .failure(_):
                hideProgressIndicator(view: self.view)
                self.showToast("Server error")
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

extension APAddEducationInfoVC : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        isNumberOfSeatSelect = textField.text
        print("DidBegin \(textField.text!)")
        
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
        print("Text Field Should Return \(textField.text!)")
        //        isNumberOfSeatSelect = textField.text
        
        textField.resignFirstResponder();
        return true;
    }
    
}

extension APAddEducationInfoVC : DateTimePickerDelegate {
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        
        
    }
}
