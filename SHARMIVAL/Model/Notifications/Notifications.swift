//
//  Notifications.swift
//  JMK (iOS)
//
//  Created by Emoji Technology on 09/12/2021.
//

import UIKit

class Notifications {

    var id : String?
    var notTitle : String?
    var notDetails : String?
    var date : String?
    var readable : Bool?
    var Color = UIColor()
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    notTitle = dictionary["notTitle"] as? String
    notDetails = dictionary["notDetails"] as? String
    date = dictionary["date"] as? String
    readable = dictionary["readable"] as? Bool
        
    Color = ColorGenerator.sharedInstance.next()
    }
}
