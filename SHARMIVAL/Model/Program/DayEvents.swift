//
//  DayEvents.swift
//  SHARMIVAL
//
//  Created by Emojiios on 19/09/2022.
//

import Foundation
import SDWebImage

struct DayEvents {
    
    var id : String?
    var fName : String?
    var lName : String?
    var date : String?
    var dayIndex : Int?
    
    var barUnitWidth : Int?
    var firstDate = String()
    var lastDate = String()
    var hasNewNotifications : Bool?

    var rows = [TimeRows]()
    var Days = [TimeDays]()
    
    init(Data:[String:Any]) {
        id = Data["id"] as? String
        fName = Data["fName"] as? String
        lName = Data["lName"] as? String
        date = Data["date"] as? String
        dayIndex = Data["dayIndex"] as? Int
        barUnitWidth = Data["barUnitWidth"] as? Int
        firstDate = Data["firstDate"] as? String ?? ""
        lastDate = Data["lastDate"] as? String ?? ""
        hasNewNotifications = Data["hasNewNotifications"] as? Bool
        
        if let Rows = Data["rows"] as? [[String:Any]] {
        for item in Rows {
        rows.append(TimeRows(Data: item))
        }
        }
        
        if let days = Data["days"] as? [[String:Any]] {
        for item in days {
        Days.append(TimeDays(Data: item))
        }
        }
    }
}
            
struct TimeRows {
    var rowIndex : Int?
    var events = [TimeEvint]()
    var EventsIsFav = [TimeEvint]()
    
    init(Data:[String:Any]) {
        rowIndex = Data["rowIndex"] as? Int
        
        if let Evint = Data["events"] as? [[String:Any]] {
        for item in Evint {
        events.append(TimeEvint(Data: item))
            
        if TimeEvint(Data: item).isFav == true {
        EventsIsFav.append(TimeEvint(Data: item))
        }
            
        }
        }
    }
}
            
struct TimeEvint {
    var scheduleId : String?
    var marginLeft : Int?
    var width : Int?
    var time : String?
    var fName : String?
    var lName : String?
    var image : String?
    var isFav : Bool?
    
    init(Data:[String:Any]) {
        scheduleId = Data["scheduleId"] as? String
        marginLeft = Data["marginLeft"] as? Int
        width = Data["width"] as? Int
        time = Data["time"] as? String
        
        fName = Data["fName"] as? String
        lName = Data["lName"] as? String
        
        image = Data["image"] as? String
        isFav = Data["isFav"] as? Bool
    }
}


struct TimeDays {
    var dayId : String?
    var dayIndex : Int?
    
    init(Data:[String:Any]) {
        dayId = Data["dayId"] as? String
        dayIndex = Data["dayIndex"] as? Int
    }
}
