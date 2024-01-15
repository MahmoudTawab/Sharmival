//
//  Profile.swift
//  SHARMIVAL
//
//  Created by Emojiios on 12/09/2022.
//

import Foundation

class Profile {

    var fName : String?
    var lName : String?
    var mobile : String?
    var email : String?
    var image : String?
    
    init(dictionary:[String:Any]) {
        fName = dictionary["fName"] as? String
        lName = dictionary["lName"] as? String
        mobile = dictionary["mobile"] as? String
        email = dictionary["email"] as? String
        image = dictionary["image"] as? String
    }
}
