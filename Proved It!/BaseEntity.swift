//
//  BaseEntity.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Foundation
import CoreData

class BaseEntity: NSManagedObject {
    @NSManaged var created: NSDate
    @NSManaged var modified: NSDate
    @NSManaged var id: Int32
    
    override func awakeFromInsert() {
        created = NSDate()
        modified = NSDate()
    }
    
    override func willSave() {
        guard !isApproximatelyNow(modified) else {
            return
        }
        
        modified = NSDate()
    }
    
    private func isApproximatelyNow(date: NSDate?) -> Bool {
        guard let date = date else {
            return false
        }
        
        let timeInterval = date.timeIntervalSinceDate(NSDate())
        
        return timeInterval <= 30
    }
}
