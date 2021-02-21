//
//  APInitialVC.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit

class APInitialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()

        if userObj?.type == "student" {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "APStudentTabBarVC")
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            UIApplication.shared.keyWindow?.rootViewController = nav
        } else if userObj?.type == "employee" {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "APTabBarVC")
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            UIApplication.shared.keyWindow?.rootViewController = nav

        }
//        if userObj != nil {
//            let storyboard = UIStoryboard(name: "Home", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "APTabBarVC")
//            let nav = UINavigationController(rootViewController: vc)
//            nav.isNavigationBarHidden = true
//            UIApplication.shared.keyWindow?.rootViewController = nav
//
//        }
//        else {
//            
//        }
        
            
        // Do any additional setup after loading the view.
    }
    @IBAction private func btnLogin_Pressed(_ sender : UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APLoginVC") as? APLoginVC else {
        return
        }
        self.navigationController?.pushViewController(vc, animated: true )

    }
    
    @IBAction private func btnEmail_SignUp(_ sender : UIButton) {
          guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APEmailVC") as? APEmailVC else {
          return
          }
          self.navigationController?.pushViewController(vc, animated: true )

      }
  

}

class ActualGradientButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        
//
//        UIColor(red: 143/255.0, green: 93/255.0, blue: 68/255.0,alpha: 1).cgColor ,
        l.colors = [UIColor(red: 246/255.0, green: 160/255.0, blue: 58/255.0,alpha: 0.9).cgColor ,
                    UIColor(red: 34/255.0, green: 59/255.0, blue: 116/255.0,alpha: 0.9).cgColor ,
                    UIColor(red: 143/255.0, green: 93/255.0, blue: 68/255.0,alpha: 1).cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        l.cornerRadius = 30
        layer.insertSublayer(l, at: 0)
        return l
    }()

}

//private var maxLengths = [UITextView: Int]()
//
//extension UITextView : UITextViewDelegate {
//
//  @IBInspectable var maxLength: Int {
//
//    get {
//
//      guard let length = maxLengths[self]
//        else {
//          return Int.max
//      }
//      return length
//    }
//    set {
//      maxLengths[self] = newValue
//      self.delegate = self
//    }
//  }
//    
//    public var placeholder: String? {
//        get {
//            var placeholderText: String?
//            
//            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
//                placeholderText = placeholderLabel.text
//            }
//            
//            return placeholderText
//        }
//        set {
//            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
//                placeholderLabel.text = newValue
//                placeholderLabel.sizeToFit()
//            } else {
//                self.addPlaceholder(newValue!)
//            }
//        }
//    }
//    
//    private func resizePlaceholder() {
//        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
//            let labelX = self.textContainer.lineFragmentPadding
//            let labelY = self.textContainerInset.top - 2
//            let labelWidth = self.frame.width - (labelX * 2)
//            let labelHeight = placeholderLabel.frame.height
//            
//            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
//        }
//    }
//    
//    /// Adds a placeholder UILabel to this UITextView
//    private func addPlaceholder(_ placeholderText: String) {
//        let placeholderLabel = UILabel()
//        
//        placeholderLabel.text = placeholderText
//        placeholderLabel.sizeToFit()
//        
//        placeholderLabel.font = self.font
//        placeholderLabel.textColor = UIColor.lightGray
//        placeholderLabel.tag = 100
//        
//        placeholderLabel.isHidden = self.text.count > 0
//        
//        self.addSubview(placeholderLabel)
//        self.resizePlaceholder()
//        self.delegate = self
//    }
//
//
//  @objc func limitLength(textView: UITextView) {
//    guard let prospectiveText = textView.text,
//      prospectiveText.count > maxLength
//      else {
//        return
//    }
//
//    let selection = selectedTextRange
//    let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
//    text = String(prospectiveText[..<maxCharIndex])
//    selectedTextRange = selection
//
//  }
//
//    public func textViewDidChange(_ textView: UITextView) {
//        limitLength(textView:textView)
//  }
//
//  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//    scrollToBottom()
//    return true
//  }
//
//  public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//    scrollToBottom()
//    return true
//  }
//
//  func scrollToBottom() {
//    let location = text.count - 1
//    let bottom = NSMakeRange(location, 1)
//    self.scrollRangeToVisible(bottom)
//  }
//
//}
