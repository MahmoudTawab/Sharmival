//
//  ExtensionDate.swift
//  LLDC
//
//  Created by Emojiios on 12/06/2022.
//

import UIKit
import Foundation

extension Date {
    
func Formatter(_ dateFormat: String = "yyyy-MM-dd") -> String {
let dateFormatter = DateFormatter()
dateFormatter.locale = Locale(identifier: "en")
dateFormatter.dateFormat = dateFormat
let calendar = NSCalendar.current
let components = calendar.dateComponents([.year, .month, .day, .hour ,.minute ,.second], from: self)
let finalDate = calendar.date(from:components) ?? Date()
return dateFormatter.string(from: finalDate)
}


static func - (lhs: Date, rhs: Date) -> TimeInterval {
return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
}
    
}
