//
//  ProofEntity+CoreDataProperties.swift
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

extension ProofEntity {

    @NSManaged var date: NSTimeInterval
    @NSManaged var message: String?
    @NSManaged var relationship: RelationshipEntity?
    @NSManaged var winningUser: UserEntity?
    @NSManaged var losingUser: UserEntity?

}
