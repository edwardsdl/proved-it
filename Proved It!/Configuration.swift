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
    
    var targetDate: Date {
        return Calendar.current.startOfDay(for: Date()).addingTimeInterval(time)
    }
    
    var isTargetDateInFuture: Bool {
        return Date().compare(targetDate) == .orderedAscending
    }
    
    var formattedTimeUntilTargetDate: String {
        if isTargetDateInFuture {
            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: targetDate)
            let hours = String(format: "%02d", abs(components.hour ?? 0))
            let minutes = String(format: "%02d", abs(components.minute ?? 0))
            let seconds = String(format: "%02d", abs(components.second ?? 0))
            let formattedTimeUntilTargetDate = "\(hours):\(minutes):\(seconds)"
            
            return formattedTimeUntilTargetDate
        } else {
            return "00:00:00"
        }
    }
    
    var formattedTargetDate: String {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let date = startOfDay.addingTimeInterval(time)
        let formattedTime = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
        
        return formattedTime
    }
}
