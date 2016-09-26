//
//  NSManagedObject+Init.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/22/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

extension NSManagedObject {
    convenience init(insertedInto managedObjectContext: NSManagedObjectContext) {
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: type(of: self)), in: managedObjectContext)

        self.init(entity: entityDescription!, insertInto: managedObjectContext)
    }
}
