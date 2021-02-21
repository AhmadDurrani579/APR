//
//  LoginResponse.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 26/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import Foundation

struct LoginResponse: Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: Session?
    
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

struct VideoResponse: Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: VideoAdd?
    
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

struct VideoAdd : Codable {
    var company_id : String?
    var company_name: String?
    var company_image: String?

    enum CodingKeys: String, CodingKey {
        
        case company_id = "company_id"
        case company_name = "company_name"
        case company_image = "company_image"
        
    }
    
}


//{
//    "success": true,
//    "status": 200,
//    "message": "Video Saved",
//    "data": {
//        "company_id": "",
//        "company_name": "",
//        "company_image": ""
//    }
//}

struct Session: Codable {
    var id : String?
    var name: String?
    var email: String?
    var picture : String?
    var type: String?
    var gender : String?
    var interests : String?
    var location : String?
    var distance : String?
    var latitude: String?
    var longitude: String?
    var language: String?
    var notifications : String?
    var user_id: String?
    var company_image   : String
    var company_id : String?
    var company_name : String?
    var phone_number : String?
    var company_info : String?
    var provider_id : String?
    var provider : String?
    var cover_letter : String?
    var pitchVideo : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case picture = "picture"
        case email = "email"
        case type = "type"
        case gender = "gender"
        case interests = "interests"
        case location = "location"
        case distance = "distance"
        case latitude = "latitude"
        case longitude = "longitude"
        case language = "language"
        case company_id = "company_id"
        case company_name = "company_name"
        case company_image = "company_image"
        case notifications = "notifications"
        case user_id = "user_id"
        case phone_number = "phone_number"
        case company_info = "company_info"
        case provider_id = "provider_id"
        case provider = "provider"
        case cover_letter = "cover_letter"
        case pitchVideo = "pitch_video"
    }
    
}

struct StudentLoginResponse: Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: StudentInfo?
    
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



struct StudentInfo: Codable {
    var id : String?
    var name: String?
    var email: String?
    var picture : String?
    var type: String?
    var gender : String?
    var interests : String?
    var location : String?
    var distance : String?
    var latitude: String?
    var longitude: String?
    var language: String?
    var notifications : String?
    var provider_id : String?
    var provider : String?

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case picture = "picture"
        case email = "email"
        case type = "type"
        case gender = "gender"
        case interests = "interests"
        case location = "location"
        case distance = "distance"
        case latitude = "latitude"
        case longitude = "longitude"
        case language = "language"
        case notifications = "notifications"
        case provider_id = "provider_id"
        case provider = "provider"

        
    }
    
}

struct EmailValidation : Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case status  = "status"
        
    }
    

}
