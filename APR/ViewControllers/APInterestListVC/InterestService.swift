//
//  InterestService.swift
//  APR
//
//  Created by Ahmed Durrani on 15/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct Interest : Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: [InterestList]?
    
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

struct InterestList : Codable {
    var id : String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
}
