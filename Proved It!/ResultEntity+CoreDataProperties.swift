//
//  ResultEntity+CoreDataProperties.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ResultEntity {

    @NSManaged var date: NSTimeInterval
    @NSManaged var message: String?
    @NSManaged var losingUser: UserEntity?
    @NSManaged var relationship: RelationshipEntity?
    @NSManaged var winningUser: UserEntity?

}
