//
//  JobResponse.swift
//  APR
//
//  Created by Ahmed Durrani on 03/02/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import Foundation

struct Job : Response {
    
    var success: Bool?
    var status  : Int?
    var message: String?
    var data  : [JobList]?
    
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



struct JobList: Codable {
    
    var user_id : String?
    var name: String?
    var gender: String?
    var interests : String?
    var descriptionOfUser : String?
    var location : String?
    var email : String?
    var picture : String?
    var cover_letter : String?
    var distance : String?
    var latitude : String?
    var longitude : String?
    var pitch_video : String?
    var job_type : String?
    var skills : String?
    var education : [EducationOfUser]?
    var experince : [ExperienceOfUser]?
    
    enum CodingKeys: String, CodingKey {
        case user_id = "id"
        case name = "name"
        case gender = "gender"
        case interests = "interests"
        case descriptionOfUser = "description"
        case location = "location"
        case email = "email"
        case picture = "picture"
        case distance = "distance"
        case cover_letter = "cover_letter"
        case latitude = "latitude"
        case longitude = "longitude"
        case pitch_video = "pitch_video"
        case job_type = "job_type"
        case skills = "skills"
        case education = "education"
        case experince = "experience"
    }
    
}
struct EducationOfUser: Codable {
    
    var id : String?
    var user_id: String?
    var school: String?
    var degree : String?
    var field : String?
    var start_date : String?
    var end_date : String?
    var descriptionOfEducation : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case school = "school"
        case degree = "degree"
        case field = "field"
        case start_date = "start_date"
        case end_date = "end_date"
        case descriptionOfEducation = "description"
        
    }
    
}

struct ExperienceOfUser: Codable {
    
    var id : String?
    var user_id: String?
    var title: String?
    var company : String?
    var current_role : String?
    var location : String?
    var start_date : String?
    var end_date : String?
    var descriptionOfExperience : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user_id = "user_id"
        case title = "title"
        case company = "company"
        case current_role = "current_role"
        case location = "location"
        case end_date = "end_date"
        case start_date = "start_date"

        case descriptionOfExperience = "description"
        
    }
    
}
