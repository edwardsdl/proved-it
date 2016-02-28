//
//  CoreDataStoreFactory.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/27/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

enum CoreDataStoreConfiguration {
    case Default
    case UnitTest

    private var managedObjectModelUrl: NSURL? {
        let mainBundle = NSBundle.mainBundle()
        let managedObjectModelUrl = mainBundle.URLForResource("ProvedIt", withExtension: "momd")

        return managedObjectModelUrl
    }

    private var persistentStoreUrl: NSURL? {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let url = urls.last

        switch self {
        case .Default:
            let persistentStoreUrl = url?.URLByAppendingPathComponent("ProvedIt.sqlite")

            return persistentStoreUrl
        case .UnitTest:
            let persistentStoreUrl =  url?.URLByAppendingPathComponent("ProvedItUnitTests.sqlite")

            return persistentStoreUrl
        }
    }

    private var storeType: String {
        switch self {
        case .Default:
            return NSSQLiteStoreType
        case .UnitTest:
            return NSInMemoryStoreType
        }
    }

    private var persistentStoreOptions: [String: AnyObject] {
        var options = [String: AnyObject]()
        options[NSMigratePersistentStoresAutomaticallyOption] = true
        options[NSInferMappingModelAutomaticallyOption] = true
        options[NSSQLitePragmasOption] = ["journal_mode": "DELETE"]

        return options
    }
}

final class CoreDataStoreFactory {
    private init() {

    }

    static func createCoreDataStore(withCoreDataStoreConfiguration coreDataStoreConfiguration: CoreDataStoreConfiguration) -> CoreDataStoreType? {
        do {
            let managedObjectModel = try initializeManagedObjectModel(withCoreDataStoreConfiguration: coreDataStoreConfiguration)
            let persistentStoreCoordinator = initializePersistentStoreCoordinator(withCoreDataStoreConfiguration: coreDataStoreConfiguration, managedObjectModel: managedObjectModel)
            let persistentStore = try initializePersistentStore(withCoreDataStoreConfiguration: coreDataStoreConfiguration, persistentStoreCoordinator: persistentStoreCoordinator)
            let privateManagedObjectContext = initializePrivateManagedObjectContext(withPersistentStoreCoordinator: persistentStoreCoordinator)
            let mainManagedObjectContext = initializeMainManagedObjectContext(withPrivateManagedObjectContext: privateManagedObjectContext)

            switch coreDataStoreConfiguration {
            case .Default:
                let coreDataStore = CoreDataStore(withManagedObjectModel: managedObjectModel, persistentStoreCoordinator: persistentStoreCoordinator, persistentStore: persistentStore, privateManagedObjectContext: privateManagedObjectContext, mainManagedObjectContext: mainManagedObjectContext)

                return coreDataStore
            case .UnitTest:
                let unitTestCoreDataStore = UnitTestCoreDataStore(withManagedObjectModel: managedObjectModel, persistentStoreCoordinator: persistentStoreCoordinator, persistentStore: persistentStore, privateManagedObjectContext: privateManagedObjectContext, mainManagedObjectContext: mainManagedObjectContext)

                return unitTestCoreDataStore
            }
        } catch {
            return nil
        }
    }

    private static func initializeManagedObjectModel(withCoreDataStoreConfiguration coreDataStoreConfiguration: CoreDataStoreConfiguration) throws -> NSManagedObjectModel {
        guard let managedObjectModelUrl = coreDataStoreConfiguration.managedObjectModelUrl, managedObjectModel = NSManagedObjectModel(contentsOfURL: managedObjectModelUrl) else {
            throw CoreDataError.UnableToInitializeManagedObjectModel
        }

        return managedObjectModel
    }

    private static func initializePersistentStoreCoordinator(withCoreDataStoreConfiguration coreDataStoreConfiguration: CoreDataStoreConfiguration, managedObjectModel: NSManagedObjectModel) -> NSPersistentStoreCoordinator {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        return persistentStoreCoordinator
    }

    private static func initializePersistentStore(withCoreDataStoreConfiguration coreDataStoreConfiguration: CoreDataStoreConfiguration, persistentStoreCoordinator: NSPersistentStoreCoordinator) throws -> NSPersistentStore {
        guard let persistentStoreUrl = coreDataStoreConfiguration.persistentStoreUrl, persistentStore = try? persistentStoreCoordinator.addPersistentStoreWithType(coreDataStoreConfiguration.storeType, configuration: nil, URL: persistentStoreUrl, options: coreDataStoreConfiguration.persistentStoreOptions) else {
            throw CoreDataError.UnableToInitializePersistentStore
        }

        return persistentStore
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
