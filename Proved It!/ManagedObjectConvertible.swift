//
//  ManagedObjectConvertible.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/22/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

protocol ManagedObjectConvertible {
    typealias T: NSManagedObject

    init(withManagedObject managedObject: T)
    func toManagedObject(insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) -> T
}
