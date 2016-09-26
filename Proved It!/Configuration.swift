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
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: Date())
        let date = startOfDay.addingTimeInterval(time)
        let formattedTime = DateFormatter.localizedString(from: date, dateStyle: .none, timeStyle: .short)
        
        return formattedTime
    }
}
