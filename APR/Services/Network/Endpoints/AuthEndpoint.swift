//
//  AuthEndpoint.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 25/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import Foundation
import UIKit

enum AuthEndpoint : Endpoint {
    
    case login(email: String, password: String)
    case signUp(name : String , type : String ,  device: String, device_id : String ,  password : String , email : String , image : Data)
    case addSkill(userId : String , skills : String )

    case employeeSignUp(email : String , location: String , password : String , type : String , company_name  : String , phone_number : String , latitude : String , longitude : String , company_info  : String , image : Data)
    case interestList
    case educationAdd(school : String , user_id : String , degree : String , field : String , start_date : String , endDate : String , descriptionOfUni : String)
    case userInterest(location : String , user_id : String , distance : String , latitude : String , longitude : String , interests : String )
    case experienceAdd(title : String , company : String , current_role : String , location : String , start_date : String , endDate : String , descriptionOfExperience : String , user_id : String)
    case coverLetter( userId : String , coverLetter : String , interests : String , jobType : String , skill : String , location : String , distance : String , latitude : String , longitude : String )

    case getJobFairs
    case getSkillsList
    case getJobTypeList

    case getUsersArround(distance: String?  , latitude : String? , longitude : String? , interests : String? , company_id : String)
    case getJobs(companyId : String)
    case createJob(company_id : String , job_title : String , position : String , location : String , experience : String , employment_type : String , start_date : String , latitude : String , longitude : String , salary : String , descriptionOfJob : String , skill : String , interest : String , image : Data)
    
    case interestingOrNot(companyId : String , userId : String , interest : String)
    case notificationList( userId : String)
    case updateProfileImage( userId : String , image : Data ,  companyId : String)
    case studentProfileImage( userId : String , image : Data )

    case updateNotification( userId : String , isNotificationOnOroff : String , companyId : String)
    case resetPassword( userId : String , password  : String)
    case profileStudent( userId : String)
    case createJobFair(company_id : String , job_title : String ,  start_time: String, end_time : String ,  price : String , start_date : String , latitude : String , longitude : String ,descriptionOfJob : String , image : Data)
    case eventRegistration( jobfair_id : String , quantity : String , first_name : String , last_name : String , email_address : String , user_id : String)

    
    case profile
    case deactivatAccount
    case superMarket
    case shopping(superMarket: String , postalCode : String , shippingAddress : String , items : String)
    case orders
    case rating(recipeId : String , rating : String)
    case pitchVideoUpload( userId : String , video : Data )
    case checkEmail( email : String)
    case updateLocation(userId : String ,location : String , latitude : String , longitude : String)
    case searchFilter(distance : String , location : String , jobType : String , latitude : String , longitude : String , skills : String , interests : String)
   

    var path: String {
        switch self {
        case .login(_,_):
            return "signup/login"
        case .addSkill(_ , _) :
            return "signup/usergeneration"
        case .signUp(_ , _ , _ , _ , _ , _ , _):
            return  "signup/usergeneration"
        case .employeeSignUp(_ , _ , _ , _ , _ , _ , _ , _ , _ , _):
            return  "signup/companygeneration"

        case .interestList:
            return "app/interests"
        case .educationAdd(_ , _ , _ , _ , _ , _ , _):
            return "app/education"
        case .userInterest(_ , _ , _ , _ , _ , _):
                return "signup/usergeneration"

        case .experienceAdd(_ , _ , _ , _ , _ , _ , _ , _) :
            return "app/experience"
        case .getJobFairs:
            return "app/getJobFairs"
        case .getSkillsList:
                return "app/skills"
        case .getJobTypeList:
                return "app/jobtypes"
        case .getUsersArround(_ , _ , _ , _ , _):
            return "app/getUsersArround"
        case .getJobs(_ ):
            return "app/getJobs"
        case .createJob(_ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _):
            return "app/addjob"
        case .profile:
            return "profile"
        case .deactivatAccount :
            return "deactive-account"
        case .superMarket :
            return "get-super-markets"
        case .shopping(_ , _ , _ , _) :
            return "shoping"
        case .orders :
             return "getOrders"
        case .rating(_ , _) :
             return "rating"
        case .interestingOrNot(_ , _ , _):
            return "app/interestings"
        case .notificationList(_):
            return "app/getUserNotifications"
        case .updateProfileImage(_ , _ , _) :
            return "signup/companygeneration"
            
        case .updateNotification(_ , _ , _) :
            return "signup/companygeneration"
        case .resetPassword(_ , _) :
            return "signup/resetpass"
        case .profileStudent(_) :
            return "app/user"
        case .coverLetter(_ , _ , _ , _ , _ , _ , _ , _ , _ ) :
            return "signup/usergeneration"
        case .createJobFair(_, _, _, _, _, _, _ , _ , _ ,_) :
            return "app/addjobfair"
        case .eventRegistration(_, _, _, _, _, _):
            return "app/eventregistration"
        case .studentProfileImage(_ , _):
            return "signup/usergeneration"
        case .pitchVideoUpload(_ , _) :
            return "signup/pitchvideo"
        case .updateLocation(_ , _ , _ ,_):
            return "signup/usergeneration"
        case .checkEmail(_) :
            return "app/checkemail"
        case .searchFilter(_, _, _ , _, _, _, _) :
            return "app/searchfilter"
        }
        
    }

    var method: HTTPMethod {
        switch self {
        case .login(_,_):
            return .post
        case .signUp (_ , _  , _ , _ , _ , _ , _ ):
            return .post
        case .employeeSignUp (_ , _ , _ , _ , _ , _ , _ , _ , _ , _ ):
            return .post
        case .interestList:
            return .get
        case .userInterest(_ , _ , _ , _ , _ , _ ):
            return .post
        case .educationAdd(_ , _ , _ , _ , _ , _ , _):
            return .post
        case .experienceAdd(_ , _ , _ , _ , _ , _ , _ , _) :
            return .post
        case .getJobFairs:
             return .get
        case .getSkillsList:
              return .get
        case .getJobTypeList:
              return .get
        case .getUsersArround(_ , _ , _ , _ , _):
            return .post
        case .getJobs(_) :
            return .post
        case .createJob(_ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ,_):
            return .post
        case .profile:
            return .get
        case .deactivatAccount :
            return .post
        case .superMarket :
            return .get
        case .shopping(_ , _ , _ , _):
            return .post
        case .orders : 
            return .get
        case .rating(_ , _) :
            return .post
        case .interestingOrNot(_ ,  _ , _):
            return .post
        case .notificationList(_):
            return .post
        case .updateProfileImage(_ , _ , _ ) :
            return .post
        case .updateNotification(_ , _ , _) :
            return .post
        case .resetPassword(_ , _) :
            return .post
            
        case .profileStudent(_):
            return .post
        case .coverLetter(_ , _ , _ , _ , _ , _ , _ , _ , _ ):
            return .post
        case .createJobFair(_, _, _, _, _, _, _ , _ , _ ,_):
            return .post
        case .eventRegistration(_, _, _, _, _, _):
            return .post
        case .studentProfileImage(_ , _):
            return .post
        case .pitchVideoUpload(_ , _) :
            return .post
        case .checkEmail(_) :
            return .post
        case .addSkill(_ , _) :
            return .post
        case .updateLocation(_ , _ , _ ,_) :
            return .post
        case .searchFilter(_, _, _,  _, _, _, _) :
            return .post
        }
    }
    
    var contentType: HTTPContentType {
        switch self {
            case .signUp(_  , _ , _ , _ , _ , _ , _ ):
                return .multipart
             case .employeeSignUp(_ , _ , _ , _ , _ , _ , _ , _  , _ , _):
                   return .multipart
            case .createJob(_ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _) :
                    return .multipart
        case .updateProfileImage( _ , _ , _ ) :
                    return .multipart
        case .studentProfileImage( _ , _  ) :
                return .multipart
        case .pitchVideoUpload( _ , _  ) :
            return .multipart
       case .createJobFair(_, _, _, _, _, _, _ , _ , _ ,_) :
                    return .multipart
        default:
            return .form
        }
    }

    var query: HTTPParameters {
        var query = HTTPParameters()
        switch self {
//        case .coachList(let serviceId , let lat , let lng):
//            query["serviceCategoryId"] = serviceId
//            query["latitude"] = lat
//            query["longitude"] = lng
       
        default:
            break
        }
        return query
    }

    var body: HTTPParameters {
        var body = HTTPParameters()
        
        switch self {
        case .login(let email, let password):
            body["email"] = email
            body["password"] = password
        case .signUp(let name, let type, let device, let device_id, let password , let email , _) :
            body["name"] = name
            body["type"] = type
            body["device"] = device
            body["device_id"] = device_id
            body["password"] = password
            body["email"] = email
//            body["gender"] = gender
            
        case .employeeSignUp(let email , let location , let password , let type , let company_name , let phone_number , let latitude , let longitude , let company_info , _):
            body["email"] = email
            body["location"] = location
            body["password"] = password
            body["type"] = type
            body["company_name"] = company_name
            body["phone_number"] = phone_number
            body["latitude"] = latitude
            body["longitude"] = longitude
            body["company_info"] = company_info
        case .educationAdd(let school, let  user_id, let degree , let field , let start_date , let endDate, let descriptionOfUni):
            body["school"] = school
            body["user_id"] = user_id
            body["degree"] = degree
            body["field"] = field
            body["start_date"] = start_date
            body["end_date"] = endDate
            body["description"] = descriptionOfUni

        case .experienceAdd(let title ,let company , let current_role , let location , let start_date , let endDate ,let descriptionOfExperience , let user_id):
            body["title"] = title
            body["company"] = company
            body["current_role"] = current_role
            body["location"] = location
            body["start_date"] = start_date
            body["end_date"] = endDate
            body["description"] = descriptionOfExperience
            body["user_id"] = user_id
        case .userInterest(let location , let user_id , let distance , let latitude , let longitude ,let  interests ) :
            body["location"] = location
            body["userid"] = user_id
            body["distance"] = distance
            body["latitude"] = latitude
            body["longitude"] = longitude
            body["interests"] = interests

        case .getUsersArround(let distance , let latitude , let longitude , let interests , let company_id ):
             body["distance"] = distance
             body["latitude"]   = latitude
             body["longitude"]   = longitude
             body["interests"]   = interests
             body["company_id"]   = company_id
             
        case .createJob(let company_id , let  job_title , let position , let  location ,let  experience , let  employment_type , let  start_date , let latitude ,  let longitude , let  salary , let  descriptionOfJob , let skill ,let interest , _) :
            body["company_id"] = company_id
            body["job_title"] = job_title
            body["position"] = position
            body["location"] = location
            body["experience"] = experience
            body["employment_type"] = employment_type
            body["start_date"] = start_date
            body["latitude"] = latitude
            body["longitude"] = longitude
            body["salary"] = salary
            body["description"] = descriptionOfJob
            body["skills"] = skill
            body["interests"] = interest

        case .getJobs(let companyId):
            body["company_id"] = companyId
            
        case .interestingOrNot(let companyId , let  userId , let interest) :
            body["company_id"] = companyId
            body["user_id"] = userId
            body["interest"] = interest
         case .notificationList( let userId) :
            body["user_id"] = userId
         
        case .updateProfileImage(let userId  , _ , let companyId) :
               body["user_id"] = userId
               body["company_id"] = companyId

        case .studentProfileImage(let userId  , _ ) :
               body["userid"] = userId
        case .pitchVideoUpload(let userId, _) :
                body["userid"] = userId

        case .updateNotification(let userId , let  isNotificationOnOroff , let companyId ) :
            body["user_id"] = userId
            body["notifications"] = isNotificationOnOroff
            body["company_id"] = companyId

        case .resetPassword(let userId , let password) :
            body["userid"] = userId
            body["password"] = password
        
        case .coverLetter(let userId , let  coverLetter , let  interests , let  jobType , let skill , let  location ,let  distance ,let  latitude ,let  longitude) :
             body["userid"] = userId
             body["cover_letter"] = coverLetter
            body["location"] = location
            body["distance"] = distance
            body["latitude"] = latitude
            body["longitude"] = longitude
            body["interests"] = interests
            body["job_type"] = jobType
            body["skills"] = skill
        case .updateLocation(let userId, let location , let  latitude , let  longitude) :
            body["userid"] = userId
            body["location"] = location
            body["latitude"] = latitude
            body["longitude"] = longitude

        case .profileStudent(let userId) :
                body["userid"] = userId

        case .createJobFair(let company_id , let  job_title ,let  start_time , let end_time , let  price ,let  start_date ,let  latitude , let longitude , let  descriptionOfJob , _) :
                body["company_id"] = company_id
                body["job_title"] = job_title
                body["start_time"] = start_time
                body["end_time"] = end_time
                body["price"] = price
                body["start_date"] = start_date
                body["latitude"] = latitude
                body["longitude"] = longitude
                body["description"] = descriptionOfJob
            
        case .eventRegistration(let jobfair_id ,let  quantity , let first_name, let last_name , let email_address ,let  user_id):
            body["jobfair_id"] = jobfair_id
            body["quantity"] = quantity
            body["first_name"] = first_name
            body["last_name"] = last_name
            body["email_address"] = email_address
            body["user_id"] = user_id
            
        case .checkEmail(let email) :
            body["email"] = email
        case .addSkill(let userId , let skills) :
            body["skills"] = skills
            body["userid"] = userId
        case .searchFilter(let distance , let  location , let  jobType, let  latitude , let  longitude , let  skills , let  interests) :
            body["distance"] = distance
            body["location"] = location
            body["jobtype"] = jobType
            body["latitude"] = latitude
            body["longitude"] = longitude
            body["skills"] = skills
            body["interests"] = interests

        case .deactivatAccount :
            break
        default:
            break
        }
        return body
    }

    var multipart: [HTTPMultipart] {
        var multipart: [HTTPMultipart] = []
        switch self {
        case .signUp(_ , _  , _ , _ , _ , _ , let image):
            multipart.append(HTTPMultipart(key: "image", filename: "image.png", data: image, mimeType: "image/png"))
        case .employeeSignUp(_ , _ , _ , _ , _ , _ , _ , _ , _ , let image):
                multipart.append(HTTPMultipart(key: "image", filename: "image.png", data: image, mimeType: "image/png"))
        case .createJob(_ , _ , _ , _ , _ , _ , _ , _ , _ , _ , _ ,_,_ , let image):
                multipart.append(HTTPMultipart(key: "image", filename: "image.png", data: image, mimeType: "image/png"))
        case .updateProfileImage(_ , let image , _ ):
            multipart.append(HTTPMultipart(key: "image", filename: "image.png", data: image, mimeType: "image/png"))
        case .createJobFair(_ , _ , _ , _ , _ , _ , _ , _ , _ ,  let image):
                multipart.append(HTTPMultipart(key: "image", filename: "image.png", data: image, mimeType: "image/png"))
            
        case .studentProfileImage(_ ,let  image):
                multipart.append(HTTPMultipart(key: "image", filename: "image.png", data: image, mimeType: "image/png"))
        case .pitchVideoUpload(_, let video ):
                multipart.append(HTTPMultipart(key: "pitch_video", filename: "pitch_video.mp4", data: video , mimeType: "video/mp4"))
        default:
            break
        }
        return multipart
    }
}

