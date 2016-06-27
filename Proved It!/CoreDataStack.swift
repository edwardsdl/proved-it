//
//  CoreDataStack.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/27/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

enum CoreDataStackConfiguration {
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

final class CoreDataStack {
    var managedObjectModel: NSManagedObjectModel!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var persistentStore: NSPersistentStore!
    var managedObjectContext: NSManagedObjectContext!
    
    init?(withConfiguration configuration: CoreDataStackConfiguration) {
        do {
            managedObjectModel = try initializeManagedObjectModel(withConfiguration: configuration)
            persistentStoreCoordinator = initializePersistentStoreCoordinator(withConfiguration: configuration, managedObjectModel: managedObjectModel)
            persistentStore = try initializePersistentStore(withConfiguration: configuration, persistentStoreCoordinator: persistentStoreCoordinator)
            managedObjectContext = initializeManagedObjectContext(withPersistentStoreCoordinator: persistentStoreCoordinator)
        } catch {
            return nil
        }
    }
    
    private func initializeManagedObjectModel(withConfiguration configuration: CoreDataStackConfiguration) throws -> NSManagedObjectModel {
        guard let managedObjectModelUrl = configuration.managedObjectModelUrl, managedObjectModel = NSManagedObjectModel(contentsOfURL: managedObjectModelUrl) else {
            throw CoreDataError.UnableToInitializeManagedObjectModel
        }
        
        return managedObjectModel
    }
    
    private func initializePersistentStoreCoordinator(withConfiguration configuration: CoreDataStackConfiguration, managedObjectModel: NSManagedObjectModel) -> NSPersistentStoreCoordinator {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        return persistentStoreCoordinator
    }
    
    private func initializePersistentStore(withConfiguration configuration: CoreDataStackConfiguration, persistentStoreCoordinator: NSPersistentStoreCoordinator) throws -> NSPersistentStore {
        guard let persistentStoreUrl = configuration.persistentStoreUrl, persistentStore = try? persistentStoreCoordinator.addPersistentStoreWithType(configuration.storeType, configuration: nil, URL: persistentStoreUrl, options: configuration.persistentStoreOptions) else {
            throw CoreDataError.UnableToInitializePersistentStore
        }
        
        return persistentStore
    }
    
    private func initializeManagedObjectContext(withPersistentStoreCoordinator persistentStoreCoordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
}
