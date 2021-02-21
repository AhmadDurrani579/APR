//
//  Extensions.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 24/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import UIKit
import Toast_Swift
extension UITableView {
    func registerCells(_ cells: [UITableViewCell.Type]) {
        cells.forEach({ register(UINib(nibName: String(describing: $0), bundle: nil), forCellReuseIdentifier: String(describing: $0)) })
    }
    
    func registerHeaderFooter(_ headerFooter: [UITableViewHeaderFooterView.Type]) {
        headerFooter.forEach({ register(UINib(nibName: String(describing: $0), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: $0)) })
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as! T
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T
    }
    
    func scrollToBottom(){
        
//        let section = self.numberOfSections
//        let row = self.numberOfRows(inSection: self.numberOfSections - 1) - 1;
//        guard (section > 0) && (row > 0) else{ // check bounds
//            return
//        }
//        let indexPath = IndexPath(row: row - 1, section: section - 1)
//        self.scrollToRow(at: indexPath, at: .top, animated: true)
            DispatchQueue.main.async {
                let indexPath = IndexPath(
                    row: self.numberOfRows(inSection:  self.numberOfSections - 1 ) - 1,
                    section: self.numberOfSections - 1)
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
}

extension UIViewController {
    func showNotification(with message: String?, viewss : UIView ,  autoDismiss: Bool = true,   handler: (() -> ())? = nil) {
        let notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.text = message
        notificationLabel.textColor = .black
        notificationLabel.textAlignment = .center
        notificationLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        notificationLabel.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        notificationLabel.numberOfLines = 0
        
        guard let navigationController = navigationController else { return }
        
//        let subviews = navigationController.navigationBar.subviews.filter({ $0 is UILabel })
        
        let subviews = viewss.subviews.filter({$0 is UILabel})
        
//        navigationController.navigationBar.insertSubview(notificationLabel, at: subviews.count > 0 ? subviews.count : 0)
        self.view.insertSubview(notificationLabel, at: subviews.count > 0 ? subviews.count : 0)
        notificationLabel.centerXAnchor.constraint(equalTo: viewss.centerXAnchor).isActive = true
        notificationLabel.topAnchor.constraint(equalTo: viewss.bottomAnchor).isActive = true
        notificationLabel.widthAnchor.constraint(equalTo: viewss.widthAnchor).isActive = true
        notificationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 32).isActive = true
        
        notificationLabel.sizeToFit()
        
        notificationLabel.transform = CGAffineTransform(translationX: 0, y: -notificationLabel.frame.height)
        
        UIView.animate(withDuration: 0.25) {
            notificationLabel.transform = .identity
        }
        
        if autoDismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                UIView.animate(withDuration: 0.25, animations: {
                    notificationLabel.alpha = 0
                    notificationLabel.transform = CGAffineTransform(translationX: 0, y: -notificationLabel.frame.height)
                }, completion: { (done) in
                    notificationLabel.removeFromSuperview()
                    handler?()
                })
            }
        }
    }

    func showToast(_ message: String?) {
        view.makeToast(message)
        
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

//extension UITextView : UITextViewDelegate
//{
//
//    /// Resize the placeholder when the UITextView bounds change
//    override open var bounds: CGRect {
//        didSet {
//            self.resizePlaceholder()
//        }
//    }
//
//    /// The UITextView placeholder text
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
//    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
//    ///
//    /// - Parameter textView: The UITextView that got updated
//    public func textViewDidChange(_ textView: UITextView) {
//        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
//            placeholderLabel.isHidden = self.text.count > 0
//        }
//    }
//
//    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
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
//}
//
//



extension UIImageView {
    
    func setImage(with urlString: String?, placeholder: UIImage? = nil) {
        
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
//        activityIndicator.center = placeholder.center
        activityIndicator.hidesWhenStopped = true
//        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.startAnimating()
        
        self.image = placeholder
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        image = nil
//        showLoading()
        
        let cache = URLCache.shared
        
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            //            hideLoading()
            self.image = image
        }
        else {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
                guard let this = self else { return }
                if let response = response, let data = data {
                    let image = UIImage(data: data)
                    
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {

                        //                        this.hideLoading()
                        this.image = image
                    }
                } else {
                    DispatchQueue.main.async {

                        //                        this.hideLoading()
                        this.image = placeholder
                    }
                }
            }
            dataTask.resume()
        }
    }
}
