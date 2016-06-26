//
//  User+CoreDataProperties.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/26/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var created: NSDate?
    @NSManaged var id: NSNumber?
    @NSManaged var modified: NSDate?
    @NSManaged var name: String?
    @NSManaged var configuration: Configuration?
    @NSManaged var losses: NSSet?
    @NSManaged var wins: NSSet?

}
