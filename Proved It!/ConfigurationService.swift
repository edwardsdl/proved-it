//
//  ConfigurationService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

final class RelationshipService {
    let configurationApiClient: ConfigurationApiClientType
    let coreDataStore: CoreDataStoreType

    init(withConfigurationApiClient configurationApiClient: ConfigurationApiClientType, coreDataStore: CoreDataStoreType) {
        self.configurationApiClient = configurationApiClient
        self.coreDataStore = coreDataStore
    }
}
