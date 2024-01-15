//
//  Setting.swift
//  SHARMIVAL
//
//  Created by Emojiios on 12/09/2022.
//

import Foundation

class Setting {
    
    var lang : Int?
    var langList = [Language]()
    var receiveNotifications : Bool?
    
    init(dictionary:[String:Any]) {
    lang = dictionary["lang"] as? Int
    receiveNotifications = dictionary["receiveNotifications"] as? Bool

    if let LangList = dictionary["langList"] as? [[String:Any]] {
    for item in LangList {
    langList.append(Language(dictionary: item))
    }
    }
    }
}

class Language {
    
    var id = Int()
    var flag = String()
    var title = String()
    var description = String()
    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? Int ?? 0
    flag = dictionary["flag"] as? String ?? ""
    title = dictionary["title"] as? String ?? ""
    description = dictionary["description"] as? String ?? ""
    }
    
    init(id:Int,flag:String,title:String) {
    self.id = id
    self.flag = flag
    self.title = title
    }
}
