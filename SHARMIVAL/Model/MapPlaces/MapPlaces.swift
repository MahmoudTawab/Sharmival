//
//  MapPlaces.swift
//  LLDC
//
//  Created by Emojiios on 18/05/2022.
//

import Foundation

class MapPlaces {
    
    var id : String?
    var name : String?
    var details : String?
    var icon : String?
    var lat : Double?
    var long : Double?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        name = dictionary["name"] as? String
        details = dictionary["details"] as? String
        icon = dictionary["icon"] as? String
        lat = dictionary["lat"] as? Double
        long = dictionary["long"] as? Double
    }
}


