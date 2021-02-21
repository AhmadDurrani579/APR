//
//  EducationResponse.swift
//  APR
//
//  Created by Ahmed Durrani on 15/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct Education : Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: [EducationRegistration]?
    
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

struct EducationRegistration : Codable {
    var id : String?
    var user_id: String?
    var school: String?
    var degree : String?
    var field: String?
    var start_date : String?
    var end_date : String?
    var descriptionOfUni : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case school = "school"
        case degree = "degree"
        case field = "field"
        case start_date = "start_date"
        case end_date = "end_date"
        case descriptionOfUni = "description"
    }
    
}
