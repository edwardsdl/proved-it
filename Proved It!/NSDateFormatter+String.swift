//
//  NSDateFormatter+String.swift
//  Proved It!
//
//  Created by Dallas Edwards on 5/4/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Foundation

extension NSDateFormatter {
    static func dateFromUtcString(string: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        let date = dateFormatter.dateFromString(string)
        
        return date
    }
    
    static func utcStringFromDate(date: NSDate) -> String? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        
        let utcString = dateFormatter.stringFromDate(date)
        
        return utcString
    }
}
