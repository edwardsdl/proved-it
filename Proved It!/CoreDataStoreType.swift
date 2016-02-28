//
//  CoreDataStore.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/12/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

protocol CoreDataStoreType {
    var persistentStoreCoordinator: NSPersistentStoreCoordinator { get }
    var persistentStore: NSPersistentStore { get }
    var privateManagedObjectContext: NSManagedObjectContext { get }
    var managedObjectContext: NSManagedObjectContext { get }
    var managedObjectModel: NSManagedObjectModel { get }

    func save()
}

extension CoreDataStoreType {
    func save() {
        managedObjectContext.performBlockAndWait({
            let _ = try? self.managedObjectContext.save()
            self.privateManagedObjectContext.performBlock({
                let _ = try? self.privateManagedObjectContext.save()
            })
        })
    }
}
