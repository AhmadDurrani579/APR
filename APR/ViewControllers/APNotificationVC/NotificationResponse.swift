//
//  NotificationResponse.swift
//  APR
//
//  Created by Ahmed Durrani on 06/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct Notification  : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : [NotificationList]?
    
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

struct NotificationList: Codable {
    var id : String?
    var noti_type : String?
    var is_read : String?
    var sender_id: String?
    var receiver_id: String?
    var senderData : SenderData?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case noti_type = "noti_type"
        case is_read = "is_read"
        case sender_id = "sender_id"
        case receiver_id = "receiver_id"
        case date = "date"
        case senderData = "sender_data"

    }
}

struct SenderData: Codable {
    var company_id : String?
    var user_id : String?
    var type : String?
    var company_name: String?
    var company_image: String?
    var latitude: String?
    var longitude: String?
    var phone_number: String?
    var company_info: String?
    var company_location: String?
    var email: String?

    enum CodingKeys: String, CodingKey {
        case company_id = "company_id"
        case user_id = "user_id"
        case type = "type"
        case company_name = "company_name"
        case company_image = "company_image"
        case latitude = "latitude"
        case longitude = "longitude"
        case phone_number = "phone_number"
        case company_info = "company_info"
        case company_location = "company_location"
        case email = "email"

    }
}
