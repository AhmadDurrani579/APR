//
//  AppDelegate.swift
//  APR
//
//  Created by Ahmed Durrani on 14/01/2020.
//  Copyright © 2020 TechEase. All rights reserved.
//

import UIKit
import CoreLocation
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

//
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SKSocketConnection.socketSharedConnection.connectSocket()
        GMSServices.provideAPIKey("AIzaSyDZwyntNbWoolNFKx1cHVRx1ZcohfE4VYs")
        GMSPlacesClient.provideAPIKey("AIzaSyDZwyntNbWoolNFKx1cHVRx1ZcohfE4VYs")

            if #available(iOS 13.0, *) {
                    window?.overrideUserInterfaceStyle = .light
             }

         IQKeyboardManager.shared.enable = true
        _ =  Location.getLocation(withAccuracy:.block, frequency: .oneShot, onSuccess: { location in
            DEVICE_LAT = location.coordinate.latitude
            DEVICE_LONG = location.coordinate.longitude
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: DEVICE_LAT, longitude: DEVICE_LONG)
            geoCoder.reverseGeocodeLocation(location, completionHandler: { placemarks, error in
                guard let addressDict = placemarks?[0].addressDictionary else {
                    return
                }
                addressDict.forEach { print($0) }
                if let formattedAddress = addressDict["FormattedAddressLines"] as? [String] {
                    DEVICE_ADDRESS = formattedAddress.joined(separator: ", ")
                }
            })
            
        }, onError: { (last, error) in
            print("Something bad has occurred \(error)")
        })

        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

