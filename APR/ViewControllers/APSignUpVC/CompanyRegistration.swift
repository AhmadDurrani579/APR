//
//  CompanyRegistration.swift
//  APR
//
//  Created by Ahmed Durrani on 15/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct CompanyRegistration : Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: CompanyInfo?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case status  = "status"
        case data = "data"
        
    }
    
    func process() {
        guard let details = data else {
            return
        }
    }
}

struct CompanyInfo: Codable {
    var company_id : String?
    var user_id: String?
    var type: String?
    var latitude : String?
    var longitude: String?
    var company_name : String?
    var company_image : String?
    var phone_number : String?
    var company_info : String?
    var company_location: String?
    var email: String?

    
    enum CodingKeys: String, CodingKey {
        case company_id = "company_id"
        case user_id = "user_id"
        case type = "type"
        case latitude = "latitude"
        case longitude = "longitude"
        case company_name = "company_name"
        case company_image = "company_image"
        case phone_number = "phone_number"
        case company_info = "company_info"
        case company_location = "company_location"
        case email = "email"
    }
    
}
