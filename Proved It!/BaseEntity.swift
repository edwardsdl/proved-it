//
//  BaseEntity.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

class BaseEntity: NSManagedObject {
    @NSManaged var created: Date
    @NSManaged var modified: Date
    @NSManaged var id: Int32
    
    override func awakeFromInsert() {
        created = Date()
        modified = Date()
    }
    
    override func willSave() {
        guard !isApproximatelyNow(modified) else {
            return
        }
        
        modified = Date()
    }
    
    fileprivate func isApproximatelyNow(_ date: Date?) -> Bool {
        guard let date = date else {
            return false
        }
        
        let timeInterval = date.timeIntervalSince(Date())
        
        return timeInterval <= 30
    }
}
