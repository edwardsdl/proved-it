//
//  Configuration.swift
//  Proved It!
//
//  Created by Dallas Edwards on 5/4/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

final class Configuration: BaseEntity {
    @NSManaged var time: Double
    @NSManaged var users: Set<User>
    
    var formattedTime: String {
        let calendar = NSCalendar.currentCalendar()
        let startOfDay = calendar.startOfDayForDate(NSDate())
        let date = startOfDay.dateByAddingTimeInterval(time)
        let formattedTime = NSDateFormatter.localizedStringFromDate(date, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        
        return formattedTime
    }
}
