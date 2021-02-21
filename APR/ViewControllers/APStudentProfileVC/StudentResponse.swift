//
//  StudentResponse.swift
//  APR
//
//  Created by Ahmed Durrani on 12/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct Student : Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: UserInfo?
    
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

struct UserInfo : Codable {
    var user : User?
    var education : [EducationOfUser]?
    var experince : [ExperienceOfUser]?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case education = "education"
        case experince = "experiences"

    }
    
}

struct User : Codable {
    var email : String?
    var name: String?
    var location : String?
    var longitude : String?
    var latitude : String?
    var gender : String?
    var picture : String?
    var interests : String?
    var distance : String?
    var language : String?
    var notifications : String?
    var descriptionOfUser : String?
    var skills            : String?
//    var location          :  String?
    var cover_letter      :  String?
    var job_type          :  String?
    var pitch_video       :  String?
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "name"
        case location = "location"
        case longitude = "longitude"
        case latitude = "latitude"
        case gender = "gender"
        case picture = "picture"
        case interests = "interests"
        case distance = "distance"
        case language = "language"
        case notifications = "notifications"
        case descriptionOfUser = "description"
        case skills = "skills"
//        case location = "location"
        case cover_letter = "cover_letter"
        case job_type = "job_type"
        case pitch_video = "pitch_video"

    }
    
}

struct EducationApped : Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: [EducationOfUser]?
    
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

struct ExperienceApped : Response {
    var success: Bool?
    var status  : Int?
    var message: String?
    var data: [ExperienceOfUser]?
    
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
