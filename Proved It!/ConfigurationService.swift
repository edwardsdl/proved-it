//
//  ConfigurationService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

final class RelationshipService {
    let configurationApiClient: ConfigurationApiClientType
    let managedObjectContext: NSManagedObjectContext

    init(withConfigurationApiClient configurationApiClient: ConfigurationApiClientType, managedObjectContext: NSManagedObjectContext) {
        self.configurationApiClient = configurationApiClient
        self.managedObjectContext = managedObjectContext
    }
}
