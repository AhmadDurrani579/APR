//
//  JobFairResponse.swift
//  APR
//
//  Created by Ahmed Durrani on 06/04/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation


struct UserJobFair  : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : JobFairList?
    
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

struct JobFairResponse  : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : [UserJobFairResponseList]?
    
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




struct UserJobFairResponseList : Codable {
    var id : String?
    var jobfair_id : String?
    var quantity : String?
    var first_name : String?
    var last_name: String?
    var email_address: String?
    var user_id : String?
    var company_id : String?
    var job_title : String?
    var latitude : String?
    var longitude : String?
    var start_date : String?
    var job_picture : String?
    var start_time : String?
    var end_time : String?
    var price : String?
    var descriptionOfJob : String?
    var address : String?
    var company_name : String?
    var company_image : String?
    var location : String?
    var phone_number : String?
    var company_info : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case jobfair_id = "jobfair_id"
        case quantity = "quantity"
        case first_name = "first_name"
        case last_name = "last_name"
        case email_address = "email_address"
        case user_id = "user_id"
        case company_id = "company_id"
        case job_title = "job_title"
        case latitude = "latitude"
        case longitude = "longitude"
        case start_date = "start_date"
        case end_time = "end_time"
        case price = "price"
        case job_picture = "job_picture"
        case descriptionOfJob = "description"
        case address = "address"
        case company_name = "company_name"
        case company_image = "company_image"
        case location = "location"
        case phone_number = "phone_number"
        case company_info = "company_info"


    }

}
