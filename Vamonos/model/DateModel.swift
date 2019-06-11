//
//  DateModel.swift
//  Vamonos
//
//  Created by Admin on 11/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

class DateModel {
    
    
    static func dateWithTimeZone(date: Date, timeZoneAbbr: String) -> String {
        let withTimeZoneFormatter = DateFormatter()
        withTimeZoneFormatter.dateFormat = "dd MMMM YYYY"
        withTimeZoneFormatter.locale = Locale(identifier: "fr_FR")
        withTimeZoneFormatter.timeZone = TimeZone(abbreviation: timeZoneAbbr)
        let dateString = withTimeZoneFormatter.string(from: date)
        return dateString
    }
    
//    static func dateToString(date: Date) -> String {
//        let toStringFormatter = DateFormatter()
//        toStringFormatter.dateFormat = "dd MMMM YYYY"
//        let dateString = toStringFormatter.string(from: date)
//        return dateString
//    }
}
