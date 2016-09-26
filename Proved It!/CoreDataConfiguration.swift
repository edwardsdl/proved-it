//
//  CoreDataConfiguration.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/27/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

enum CoreDataConfiguration {
    case `default`
    case unitTest
    
    var managedObjectModelUrl: URL? {
        let mainBundle = Bundle.main
        let managedObjectModelUrl = mainBundle.url(forResource: "ProvedIt", withExtension: "momd")
        
        return managedObjectModelUrl
    }
    
    var persistentStoreUrl: URL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls.last
    
        switch self {
        case .default:
            let persistentStoreUrl = url?.appendingPathComponent("ProvedIt.sqlite")
            
            return persistentStoreUrl
        case .unitTest:
            let persistentStoreUrl =  url?.appendingPathComponent("ProvedItUnitTests.sqlite")
            
            return persistentStoreUrl
        }
    }
    
    var storeType: String {
        switch self {
        case .default:
            return NSSQLiteStoreType
        case .unitTest:
            return NSInMemoryStoreType
        }
    }
    
    var persistentStoreOptions: [String: Any] {
        var options = [String: Any]()
        options[NSMigratePersistentStoresAutomaticallyOption] = true
        options[NSInferMappingModelAutomaticallyOption] = true
        options[NSSQLitePragmasOption] = ["journal_mode": "DELETE"]
        
        return options
    }
}
