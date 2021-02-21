//
//  APPitchVideoVC.swift
//  APR
//
//  Created by Ahmed Durrani on 12/05/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import AVFoundation
class APPitchVideoVC: UIViewController {
    var imagePicker: VideoPicker!
    @IBOutlet weak var imageOfUser: UIImageView!
    var videData : Data?
    var selectVideo  = false
    override func viewDidLoad() {
        super.viewDidLoad()
        let persistence = Persistence(with: .user)
        userObj  = persistence.load()
        self.imagePicker = VideoPicker(presentationController: self, delegate: self)
        let tapGestureRecognizerforDp = UITapGestureRecognizer(target:self, action:#selector(APPitchVideoVC.imageTappedForDp(img:)))
        imageOfUser.isUserInteractionEnabled = true
        imageOfUser.addGestureRecognizer(tapGestureRecognizerforDp)
    }
    
    @objc func imageTappedForDp(img: AnyObject)
    {
        self.imagePicker.present(from: self.view)
    }
    
    @IBAction private func btnDone_Pressed(_ sender : UIButton) {
        if selectVideo == false  {
            self.showToast("Select Video")
            return
        }
        let userId = userObj?.id
        showProgressIndicator(view: self.view)
        let endPoint = AuthEndpoint.pitchVideoUpload(userId: userId!, video: videData!)
        let context = (self)
        NetworkLayer.fetch(endPoint, with: LoginResponse.self) {[weak self] (result ) in
            switch result {
            case .success(let response):
                if response.status == 200 {
                    hideProgressIndicator(view: context.view)
                    context.showToast(response.message)
                    self?.navigationController?.popToRootViewController(animated: true)

//                    if userObj?.type == "student" {
//                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "APStudentTabBarVC")
//                        let nav = UINavigationController(rootViewController: vc)
//                        nav.isNavigationBarHidden = true
//                        UIApplication.shared.keyWindow?.rootViewController = nav
//                    } else {
//                        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                        let vc = storyboard.instantiateViewController(withIdentifier: "APTabBarVC")
//                        let nav = UINavigationController(rootViewController: vc)
//                        nav.isNavigationBarHidden = true
//                        UIApplication.shared.keyWindow?.rootViewController = nav
//                    }
                } else {
                    context.showToast(response.message!)
                    hideProgressIndicator(view: context.view)
                }
            case .failure(_):
                hideProgressIndicator(view: context.view)
                context.showToast("Server Error")
                break
                
            }
        }
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
}
extension APPitchVideoVC: VideoPickerDelegate {
    
    func didSelect(url: URL?) {
        
        guard  let urlOfVideo = url else {
            return
        }
        print("videoURL:\(String(describing: urlOfVideo))")
        selectVideo = true
        do {
            let video3 =  try Data(contentsOf: urlOfVideo, options: .mappedIfSafe)
            if let thumbnailImage = getThumbnailImage(forUrl: urlOfVideo) {
                self.imageOfUser.contentMode = .scaleAspectFill
                self.imageOfUser.image = thumbnailImage
            }
            videData = video3
        } catch {
            print(error)
            return
        }
        
        
        //        print("Hello")
    }
}

public protocol VideoPickerDelegate: class {
    func didSelect(url: URL?)
}

open class VideoPicker: NSObject {
    
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: VideoPickerDelegate?
    
    public init(presentationController: UIViewController, delegate: VideoPickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.movie"]
        self.pickerController.videoQuality = .typeMedium
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present(from sourceView: UIView) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take video") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Video library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect url: URL?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(url: url)
    }
}

extension VideoPicker: UIImagePickerControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        guard let url = info[.mediaURL] as? URL else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: url)
    }
}

extension VideoPicker: UINavigationControllerDelegate {
    
}
