//
//  JobFairResponse.swift
//  APR
//
//  Created by Ahmed Durrani on 03/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct JobFair : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : [JobFairList]?
    
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



struct JobFairList: Codable {
    
    var id : String?
    var user_id : String?
    var company_name : String?
    var company_image : String?
    var company_id: String?
    var job_title: String?
    var phone_number : String?
    var location : String?
    var latitude : String?
    var longitude : String?
    var company_info : String?
    var start_time : String?
    var end_time : String?
    var start_date : String?
    var price : String?
    var descriptionOfJob : String?
    var job_picture : String?
    var address : String?
    var companyLocation : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case company_id = "company_id"
        case company_name = "company_name"
        case company_image = "company_image"
        case job_title = "job_title"
        case phone_number = "phone_number"
        case location = "location"
        case latitude = "latitude"
        case longitude = "longitude"
        case company_info = "company_info"
        case start_time = "start_time"
        case end_time = "end_time"
        case start_date = "start_date"
        case price = "price"
        case descriptionOfJob = "description"
        case job_picture = "job_picture"
        case address = "address"
        case companyLocation = "company_location"


    }
    
}


struct JobListOfCompany : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : [CompanyJobList]?
    
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

struct AddJob  : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : CompanyJobList?
    
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



struct CompanyJobList: Codable {
    var id : String?
    var company_name : String?
    var company_image : String?
    var company_id: String?
    var job_title: String?
    var position : String?
    var location : String?
    var latitude : String?
    var longitude : String?
    var experience : String?
    var employment_type : String?
    var start_date : String?
    var salary : String?
    var descriptionOfJob : String?
    var job_picture : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case company_id = "company_id"
        case company_name = "company_name"
        case company_image = "company_image"
        case job_title = "job_title"
        case position = "position"
        case location = "location"
        case latitude = "latitude"
        case longitude = "longitude"
        case experience = "experience"
        case employment_type = "employment_type"
        case start_date = "start_date"
        case salary = "salary"
        case descriptionOfJob = "description"
        case job_picture = "job_picture"

    }
    
}
