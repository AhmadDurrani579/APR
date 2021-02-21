//
//  Response.swift
//  Grubs-up
//
//  Created by Ahmed Durrani on 25/05/2019.
//  Copyright © 2019 CyberHost. All rights reserved.
//

import Foundation

protocol Response: Codable {
    var success: Bool? { get }
    var message: String? { get }
    func process()
}

extension Response {
    func process() {}
        
}

