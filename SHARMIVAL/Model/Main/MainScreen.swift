//
//  MainScreen.swift
//  SHARMIVAL
//
//  Created by Emojiios on 08/09/2022.
//

import UIKit
import SDWebImage


class MainScreen {
    
    var isUser : Bool?
    var sqlId : String?
    var profileImage : String?
    var hasNewNotifications : Bool?
    var carnavalId : String?
    var carnavalName : String?
    var carnavalDescription : String?
    var startDate : String?
    var endDate : String?
    
    var events = [MainEvents]()
    var gallery = [MainGallery]()
    
    init(dictionary:[String:Any]) {
        
        isUser = dictionary["isUser"] as? Bool
        sqlId = dictionary["sqlId"] as? String
        profileImage = dictionary["profileImage"] as? String
        hasNewNotifications = dictionary["hasNewNotifications"] as? Bool
        carnavalId = dictionary["carnavalId"] as? String
        carnavalName = dictionary["carnavalName"] as? String
        carnavalDescription = dictionary["carnavalDescription"] as? String
        startDate = dictionary["startDate"] as? String
        endDate = dictionary["endDate"] as? String
    
        if let Events = dictionary["events"] as? [[String:Any]] {
        for item in Events {
        events.append(MainEvents(dictionary: item))
        }
        }
        
        if let Gallery = dictionary["gallery"] as? [[String:Any]] {
        for item in Gallery {
        gallery.append(MainGallery(dictionary: item))
        }
            
        }
    }
}

class MainEvents {
    
    var id : String?
    var dayId : String?
    var date : String?
    var startIn : String?
    var endIn : String?
    var fName : String?
    var lName : String?
    var image : String?
    
    init(dictionary:[String:Any]) {
        id = dictionary["id"] as? String
        dayId = dictionary["dayId"] as? String
        date = dictionary["date"] as? String
        startIn = dictionary["startIn"] as? String
        endIn = dictionary["endIn"] as? String
        fName = dictionary["fName"] as? String
        lName = dictionary["lName"] as? String
        image = dictionary["image"] as? String
    }
}


class MainGallery {
    
    var id : String?
    var name : String?
    var image : String?
    var details = [GalleryDetails]()
    var ImagesDetails = [UIImage]()

    
    init(dictionary:[String:Any]) {
    id = dictionary["id"] as? String
    name = dictionary["name"] as? String
    image = dictionary["image"] as? String
        
    if let Details = dictionary["details"] as? [[String:Any]] {
    for item in Details {
    details.append(GalleryDetails(dictionary: item))
    self.ImagesDetails.append(GalleryDetails(dictionary: item).image ?? UIImage())
    }
    }
    }
}

class GalleryDetails {
    
    var image : UIImage?
    init(dictionary:[String:Any]) {
    if let Url = URL(string: dictionary["image"] as? String ?? "") {
    SDWebImageManager.shared.loadImage(
    with: Url,
    options: .highPriority,
    progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
    if let GalleryImage = image {
    self.image = GalleryImage
    }
    }
    }
    }
    
}

func SaveProfile(_ Main:MainScreen ,_ uid:String) {
    defaults.set(uid, forKey: "uid")
    defaults.set(Main.sqlId, forKey: "sqlId")
    defaults.set(Main.carnavalId, forKey: "carnavalId")
    defaults.set(Main.profileImage, forKey: "profileImage")
    defaults.set(Main.hasNewNotifications, forKey: "hasNewNotifications")
    defaults.synchronize()
}

func SaveHasNewNotifications(_ Main:MainScreen) {
    defaults.set(Main.hasNewNotifications, forKey: "hasNewNotifications")
    defaults.synchronize()
}
