//
//  JobFairLocationCell.swift
//  APR
//
//  Created by Ahmed Durrani on 06/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import MapKit
protocol RegistrationTicketDelegate : class {
    func clickOnRegisterButton(cell : JobFairLocationCell)
}

class JobFairLocationCell: UITableViewCell {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblTitleLocation: UILabel!
    @IBOutlet weak var lblSubtitleLocation: UILabel!
    @IBOutlet weak var btnRegister: UIButton!

    weak var delegate : RegistrationTicketDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(obj : JobFairList) {
        lblTitleLocation.text = obj.companyLocation
        lblSubtitleLocation.text = obj.address
        
        guard let lat  = obj.latitude  else { return }
        guard let lng  = obj.longitude  else { return }
        
        let latitute = Double(lat)
        let longitude = Double(lng)
        let coordinate = CLLocationCoordinate2DMake(latitute!,longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: coordinate , span: span)
//        mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitute!, longitude: longitude!)
        mapView.addAnnotation(annotation)
    }
    
    @IBAction private func btnRegisterClick(_ sender : UIButton) {
        delegate?.clickOnRegisterButton(cell: self)
    }
}
