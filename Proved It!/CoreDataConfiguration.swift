//
//  CoreDataConfiguration.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/27/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

enum CoreDataConfiguration {
    case Default
    case UnitTest
    
    var managedObjectModelUrl: NSURL? {
        let mainBundle = NSBundle.mainBundle()
        let managedObjectModelUrl = mainBundle.URLForResource("ProvedIt", withExtension: "momd")
        
        return managedObjectModelUrl
    }
    
    var persistentStoreUrl: NSURL? {
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
    
    var storeType: String {
        switch self {
        case .Default:
            return NSSQLiteStoreType
        case .UnitTest:
            return NSInMemoryStoreType
        }
    }
    
    var persistentStoreOptions: [String: AnyObject] {
        var options = [String: AnyObject]()
        options[NSMigratePersistentStoresAutomaticallyOption] = true
        options[NSInferMappingModelAutomaticallyOption] = true
        options[NSSQLitePragmasOption] = ["journal_mode": "DELETE"]
        
        return options
    }
}
