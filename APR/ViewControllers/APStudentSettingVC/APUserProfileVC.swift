//
//  APUserProfileVC.swift
//  APR
//
//  Created by Ahmed Durrani on 02/06/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class APUserProfileVC: UIViewController {
    @IBOutlet var tblView: UITableView!
    var isSelectProfileOrCoverLEtterOrPitchVideo : Int?
    var selectTag : [String] = []
    var selectSkill : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isSelectProfileOrCoverLEtterOrPitchVideo = 0
        tblView.registerCells([JobDetailHeaderCell.self  , UserProfileCell.self  , CoverLetterCell.self , PitchVideoCell.self])
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 346.0
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblView.reloadData()
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
    
    func previewImageFromVideo(url: NSURL) -> UIImage? {
        let url = url as URL
        let request = URLRequest(url: url)
        let cache = URLCache.shared

        if
            let cachedResponse = cache.cachedResponse(for: request),
            let image = UIImage(data: cachedResponse.data)
        {
            return image
        }

        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        imageGenerator.maximumSize = CGSize(width: 400, height: 400)

        var time = asset.duration
        time.value = min(time.value, 2)

        var image: UIImage?

        do {
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            image = UIImage(cgImage: cgImage)
        } catch { }

        if
            let image = image,
            let data = image.pngData(),
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
        {
            let cachedResponse = CachedURLResponse(response: response, data: data)

            cache.storeCachedResponse(cachedResponse, for: request)
        }

        return image
    }


}

extension APUserProfileVC  : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(with: JobDetailHeaderCell.self, for: indexPath)
            cell.nameOfUser.text = userStudentInfo?.user?.name
            cell.lblLocation.text = userStudentInfo?.user?.location
            cell.btnBAck.isHidden = true
//            cell.btnSetting.isHidden = true
            let jobType = userStudentInfo?.user?.job_type
            cell.lblDescription.text = "Job Type :\(jobType!)"
            cell.delegate = self
            guard let img = userStudentInfo?.user?.picture else {
                return cell
            }
            WAShareHelper.loadImage(urlstring:img , imageView: ((cell.profileImage!)), placeHolder: "profile")
            let cgFloat: CGFloat = (cell.profileImage.frame.size.width)/2.0
            let someFloat = Float(cgFloat)
            GeneralUtilities.setViewCornerRadius(cell.profileImage , radius: CGFloat(someFloat))
            return cell
        } else {
            if isSelectProfileOrCoverLEtterOrPitchVideo == 0 {
                let cell = tableView.dequeueReusableCell(with: UserProfileCell.self, for: indexPath)
                cell.lblJobTitle.text = userStudentInfo?.experince![0].title
                cell.lblCompanyName.text = userStudentInfo?.experince![0].company
                cell.lblUniName.text = userStudentInfo?.education![0].school
                let degree = userStudentInfo?.education![0].degree
                let field = userStudentInfo?.education![0].field
                cell.lblDegreeProgram.text = "\(degree!) , \(field!)"
                
                let start_date = userStudentInfo?.education![0].start_date
                let end_date = userStudentInfo?.education![0].end_date
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                //            dateFormatter.timeZone = NSTimeZone(name: "UTC")
                let date = dateFormatter.date(from: start_date!)
                let enddate = dateFormatter.date(from: end_date!)
                
                dateFormatter.dateFormat = "yyyy"
                let startDate = dateFormatter.string(from: date!)
                let endDate = dateFormatter.string(from: enddate!)
                cell.lblDateFinish.text = "\(startDate) - \(endDate)"
                let array = userStudentInfo?.user?.interests!.components(separatedBy: ",")
                for (_ , service) in ((array!.enumerated())) {
                    if selectTag.contains(service) == true {
                    } else {
                        selectTag.append(service)
                        cell.tagList.addTag(service)
                    }
                }
                let arrayOfSkill = userStudentInfo?.user?.skills!.components(separatedBy: ",")
                for (_ , service) in ((arrayOfSkill!.enumerated())) {
                    if selectSkill.contains(service) == true {
                    } else {
                        selectSkill.append(service)
                        cell.skillTagList.addTag(service)
                    }
                }
                
                //                cell.tagList.delegate = self
                return cell
            } else if isSelectProfileOrCoverLEtterOrPitchVideo == 1 {
                let cell = tableView.dequeueReusableCell(with: CoverLetterCell.self, for: indexPath)
                cell.txtCoverLetter.text = userStudentInfo?.user?.cover_letter
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(with: PitchVideoCell.self, for: indexPath)
                AVAsset(url: URL(string: (userStudentInfo?.user!.pitch_video)!)!).generateThumbnail { [weak self] (image) in
                    DispatchQueue.main.async {
                        guard let image = image else { return }
                        cell.imgOfVideo.image = image
                    }
                }

                cell.delegate = self

                return cell

            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            if isSelectProfileOrCoverLEtterOrPitchVideo == 0 {
                return UITableView.automaticDimension
            } else if isSelectProfileOrCoverLEtterOrPitchVideo == 1 {
                return 297.0
            } else {
                return 223.0
            }
        }
    }
}

extension APUserProfileVC : PlayVideoDelegate {
    func playVideo(cell : PitchVideoCell)  {
        let videoURL = URL(string: (userStudentInfo?.user!.pitch_video)!)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }

    }
 
}

extension APUserProfileVC : JobDetailDelegate {
    func message(cell: JobDetailHeaderCell) {
        
    }
    
    func setting(cell: JobDetailHeaderCell) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "APStudentSettingVC") as? APStudentSettingVC else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func profile(cell: JobDetailHeaderCell) {
        isSelectProfileOrCoverLEtterOrPitchVideo = 0
        tblView.reloadData()
    }
    
    func coverLetter(cell: JobDetailHeaderCell) {
        isSelectProfileOrCoverLEtterOrPitchVideo = 1
        tblView.reloadData()
        
    }
    
    func pitchVideo(cell: JobDetailHeaderCell) {
        isSelectProfileOrCoverLEtterOrPitchVideo = 2
        tblView.reloadData()
    }
    
    func back(cell: JobDetailHeaderCell) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AVAsset {

    func generateThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            let time = CMTime(seconds: 0.0, preferredTimescale: 600)
            let times = [NSValue(time: time)]
            imageGenerator.generateCGImagesAsynchronously(forTimes: times, completionHandler: { _, image, _, _, _ in
                if let image = image {
                    completion(UIImage(cgImage: image))
                } else {
                    completion(nil)
                }
            })
        }
    }
}
