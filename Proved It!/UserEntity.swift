//
//  UserEntity.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/22/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Foundation
import CoreData


final class UserEntity: NSManagedObject {
    convenience init(insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entityForName(String(self.dynamicType), inManagedObjectContext: managedObjectContext)

        self.init(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
    }
}
