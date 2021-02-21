//
//  ZGConstants.swift
//  ZoGoo
//
//  Created by Salman Nasir on 20/02/2017.
//  Copyright © 2017 Salman Nasir. All rights reserved.
//

import UIKit



  struct setBoarder {
    let view : UIView?
    let width : CGFloat?
    let color : UIColor?
    
    @discardableResult  init(view: UIView, width: CGFloat , color : UIColor ) {
        self.view = view
        self.width  = width
        self.color  = color
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = 1
        
        

    }
}

enum WAUserType : Int
{
    case WAUser = 0 ,
    WAVendor
    
}

enum TQActionType: Int {
    case TQLogin = 0,
    TQSignup,
    TQForgetPassword ,
    TQSkip
}

var DEVICE_TOKEN: String = ""
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEGHT = UIScreen.main.bounds.height
var DEVICE_LAT =  31.582045
var DEVICE_LONG = 74.329376
var DEVICE_ADDRESS = ""
var SELECTUSER = ""



let IS_IPHONE_5 = (UIScreen.main.bounds.width == 320)
let IS_IPHONE_6 = (UIScreen.main.bounds.width == 375)
let IS_IPHONE_6P = (UIScreen.main.bounds.width == 414)

//LIVE URL

let APPID  =  "9B701345-7241-41B8-8FE6-ADF7A6854B6E"
let BASE_URL = "https://allpurposerecruiting.careers/app/"


//let COACH_SERVICE = BASE_URL + "services?"


//  API Contant

let kUserNameRequiredLength: Int = 3
let kValidationMessageMissingInput: String = "Please fill all the fields"
let kEmptyString: String = ""
let kPasswordRequiredLength: Int = 2
let kUserNameRequiredLengthForPhone: Int = 9
let kValidationMessageMissingInputPhone : String = "Please give the proper phone Number"

let KValidationPassword : String = "Password must be greater 2 digits"
let kValidationEmailInvalidInput: String = "Please enter valid Email Address"
let kValidationEmailEmpty : String = "email can't be blank"
let kValidationPasswordEmpty : String = "Password can't be blank"
let kValidationPhoneNumEmpty : String = "Phone Number can't be blank"

let kUpdateTokenMessage: String = "user does not exists"
let KMessageTitle: String = "Keodoz"
let KChoseCategory: String = "Choose Category"

let CURRENT_DEVICE = UIDevice.current
let KIDNumberValidat : String = "Id Number can't be blank"
let KIMAGeSELECT : String = "Please Select the image"

let kValidationNameInput: String = "Please Enter the name"
let kValidationNameInputCharacter : String = "Full Name must be alphabet characters.\n"
let kValidationConfirmPasswordEmpty : String = "Confirm Password can't be blank"
let KPasswordMismatch : String = "Password mismatch"
let kValidationPasswordCheck : String = "Password should be minimum 8 characters, atleast 1 Uppercase Alphabet and 1 Number"



let kValidationCardNumInput: String = "Card Number can't be blank"
let kValidationCardHolderNameInput: String = "Card Holder Name can't be blank"
let kValidationCardHolderNameInputCharacter : String = "Card Holder Name must be alphabet characters.\n"
let kValidationCardExpiryDate : String = "Expiry date can't be blank"
let kValidationCardCcvNum : String = "Ccv Number  can't be blank"



let MAIN                           = UIStoryboard(name: "Main", bundle: nil)
let HOME                           = UIStoryboard(name: "Home", bundle: nil)
var userObj  : Session?
var companyProfile : CompanyInfo?

var userStudentInfo : UserInfo?

struct VCIdentifier {
//   User ViewControllers
    static let KSIGNUP = "BLIntoViewController"
    static let kForgotPasswordController = "GSForgotPasswordVC"
    static let KHCLogin = "TSLoginVC"
    static let KTSSIGNUP = "TSSignUpVC"
    static let KDashboardVC = "HCDashboardVC"
    static let KHCCHATLISt = "HCChatListVC"
    static let KHCInterentListVC = "HCInterestListVC"
    static let KHCSelectGOal = "HCSelectGoalVC"
    static let KHCSTARTVC = "HCStartVC"

    
    
    
//    static let kEmployeeChatVC = "EmployeeChatViewController"
//    static let kEmployeeEditProfile = "EmployeeEditProfile"
//    static let kEmployeeNotification = "EmployeeNotification"
}



//

let kUserId                 : String = "user_id"
let kFirstName              : String = "firstname"
let kLastName               : String = "lastname"
let KFullName               : String = "name"
let KPhoneNum               : String = "phoneNumber"

let kEmail                  : String = "email"
let kPassword               : String = "password"

let kConfirmPassword        : String = "confirmPassword"
let KNewPassword               : String = "newPassword"
let KIdNumver               : String = "idNumber"

let KType                   : String  = "type"
let KCategory                   : String  = "category"
let KCountry                 : String  = "country"
let KCity                : String  = "city"
let KCompany                : String  = "company"



let KCODE                    : String = "code"
let KRESENTCODE              : String = "code"

let kSocialId               : String = "social_id"
let kProfileImage           : String = "profile_image"
let kSignupType             : String = "signup_type"
let kLatitude               : String = "latitute"
let kLongitude              : String = "longitude"
let kDevice                  : String = "device"
let KDeviceID                  : String = "deviceid"



let kDeviceTOken              : String = "deviceToken"
let KImageFileName                : String = "profilePicture.png"
let KImagePropertyName                : String = "propertyPicture.png"



let KImageParam                : String = "profilePicture"



let KADDRESS              : String = "address"

let KImageIDCARDName               : String = "idNumberPicture.png"
let KImageIDCardParam                : String = "idNumberPicture"

let KDeviceType                  : String = "iOS"
let KProductName                 : String  = "productName"
let KProductCategory                 : String  = "productCategory"
let KProductAddress                : String  = "productLocalisation"
let KProductDescription                 : String  = "productDescription"
let KProductPrice                 : String  = "productPrice"
let KProductImage                 : String  = "productImages"
let KProductID                 : String  = "productId"
let KSentOfferPrice                : String  = "price"

let KProductfavourite                 : String  = "favourite"
let KFavouriteBadge                 : String  = "Badge"
let KFavouriteCount                : String  = "favouriteItemCount"
let KExpiryDate                : String  = "userCardExpiry"
let KCardHolderName                : String  = "userCardHolderName"
let KUserCardNumber                : String  = "userCardNumber"
let KCardCVVNum                : String  = "userCardCsv"
let KOfferSENT                : String  = "offerSent"
let KUPDATEPROFILE                : String  = "updateProfile"

let KACCEPTOFFER                : String  = "acceptOffer"
let KREJECTOFFER                : String  = "rejectOffer"
let KNEWOFFER                : String  = "newOffer"

let KStatus                : String  = "status"
let KOfferSendUserId                : String  = "offerSenderUserId"

let KOFFERId                 : String  = "offerId"
let KCONFIRMATIONMESSAGE                 : String  = "Garage Sale is working with Services  provider to confirm your Order "




