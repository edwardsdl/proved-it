//
//  RelationshipEntity+CoreDataProperties.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/22/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension RelationshipEntity {

    @NSManaged var time: Int32
    @NSManaged var secondUser: UserEntity?
    @NSManaged var firstUser: UserEntity?

}
