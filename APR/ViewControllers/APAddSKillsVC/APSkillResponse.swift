//
//  APSkillResponse.swift
//  APR
//
//  Created by Ahmed Durrani on 18/05/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct Skills : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : [SkillsList]?
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

struct SkillsList: Codable {
    
    var id : String?
    var titleOfProgram : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case titleOfProgram = "title"
    }
    
}


struct JobType : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : [JobTypeList]?
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

struct JobTypeList: Codable {
    
    var id : String?
    var job_type : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case job_type = "job_type"
    }
    
}
