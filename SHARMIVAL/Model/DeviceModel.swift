//
//  DeviceModel.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import Foundation

class DeviceModel {
    
    var id : String?
    var jwt : String?
    var refreshToken : String?
    var refreshTokenExpiresOn : String?
    
    init(dictionary:[String:Any]) {
       
    id = dictionary["id"] as? String
    refreshToken = dictionary["refreshToken"] as? String
    refreshTokenExpiresOn = dictionary["refreshTokenExpiresOn"] as? String
        
    if let Jwt = dictionary["jwt"] as? String {
    defaults.set(Jwt, forKey: "jwt")
    defaults.synchronize()
    }
    }
}
