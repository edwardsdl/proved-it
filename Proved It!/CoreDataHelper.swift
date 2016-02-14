//
//  CoreDataHelper.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/12/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

final class CoreDataHelper {
    static func initializeManagedObjectContext() throws -> NSManagedObjectContext {
        let managedObjectModel = try initializeManagedObjectModel()
        let persistentStoreCoordinator = try initializePersistentStoreCoordinator(withManagedObjectModel: managedObjectModel)
        let privateManagedObjectContext = initializePrivateManagedObjectContext(withPersistentStoreCoordinator: persistentStoreCoordinator)
        let mainManagedObjectContext = initializeMainManagedObjectContext(withPrivateManagedObjectContext: privateManagedObjectContext)

        return mainManagedObjectContext
    }

    private static func initializeManagedObjectModel() throws -> NSManagedObjectModel {
        let mainBundle = NSBundle.mainBundle()
        let url = mainBundle.URLForResource("ProvedIt", withExtension: "momd")

        if let url = url, managedObjectModel = NSManagedObjectModel(contentsOfURL: url) {
            return managedObjectModel
        } else {
            throw CoreDataError.ManagedObjectContext(description: "Failed to create managed object model")
        }
    }

    private static func initializePersistentStoreCoordinator(withManagedObjectModel managedObjectModel: NSManagedObjectModel) throws -> NSPersistentStoreCoordinator {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let persistentStoreUrl = try self.initializePersistentStoreUrl()
        let persistentStoreOptions = self.initializePersistentStoreOptions()

        do {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: persistentStoreUrl, options: persistentStoreOptions)
        } catch {
            throw CoreDataError.PersistentStore(description: "Failed to add persistent store")
        }

        return persistentStoreCoordinator
    }

    private static func initializePersistentStoreUrl() throws -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let url = urls.last

        if let url = url {
            return url.URLByAppendingPathComponent("ProvedIt.sqlite")
        } else {
            throw CoreDataError.PersistentStore(description: "Failed to get persistent store URL")
        }
    }

    private static func initializePersistentStoreOptions() -> [String: AnyObject] {
        var options = [String: AnyObject]()
        options[NSMigratePersistentStoresAutomaticallyOption] = true
        options[NSInferMappingModelAutomaticallyOption] = true
        options[NSSQLitePragmasOption] = ["journal_mode": "DELETE"]

        return options
    }

    private static func initializePrivateManagedObjectContext(withPersistentStoreCoordinator persistentStoreCoordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        privateManagedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator

        return privateManagedObjectContext
    }

    private static func initializeMainManagedObjectContext(withPrivateManagedObjectContext privateManagedObjectContext: NSManagedObjectContext) -> NSManagedObjectContext {
        let mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        mainManagedObjectContext.parentContext = privateManagedObjectContext

        return mainManagedObjectContext
    }
}
