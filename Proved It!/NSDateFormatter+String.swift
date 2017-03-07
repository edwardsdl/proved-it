//
//  NSDateFormatter+String.swift
//  Proved It!
//
//  Created by Dallas Edwards on 5/4/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func dateFromUtcString(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let date = dateFormatter.date(from: string)
        
        return date
    }
    
    static func utcStringFromDate(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let utcString = dateFormatter.string(from: date)
        
        return utcString
    }
}
