//
//  CoreDataStore.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/27/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

final class CoreDataStore: CoreDataStoreType {
    let managedObjectModel: NSManagedObjectModel
    let persistentStoreCoordinator: NSPersistentStoreCoordinator
    let persistentStore: NSPersistentStore
    let privateManagedObjectContext: NSManagedObjectContext
    let managedObjectContext: NSManagedObjectContext

    init(withManagedObjectModel managedObjectModel: NSManagedObjectModel, persistentStoreCoordinator: NSPersistentStoreCoordinator, persistentStore: NSPersistentStore, privateManagedObjectContext: NSManagedObjectContext, mainManagedObjectContext: NSManagedObjectContext) {
        self.managedObjectModel = managedObjectModel
        self.persistentStoreCoordinator = persistentStoreCoordinator
        self.persistentStore = persistentStore
        self.privateManagedObjectContext = privateManagedObjectContext
        self.managedObjectContext = mainManagedObjectContext
    }

    func save() {
        managedObjectContext.performBlockAndWait({
            let _ = try? self.managedObjectContext.save()
            self.privateManagedObjectContext.performBlock({
                let _ = try? self.privateManagedObjectContext.save()
            })
        })
    }
}
