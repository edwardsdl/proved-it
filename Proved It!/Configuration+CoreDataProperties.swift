//
//  Configuration+CoreDataProperties.swift
//  Proved It!
//
//  Created by Dallas Edwards on 5/4/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Configuration {

    @NSManaged var created: NSDate?
    @NSManaged var id: NSNumber?
    @NSManaged var modified: NSDate?
    @NSManaged var time: NSNumber?
    @NSManaged var users: NSSet?

}
