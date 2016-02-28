//
//  RelationshipService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

final class RelationshipService {
    let relationshipApiClient: RelationshipApiClientType
    let coreDataStore: CoreDataStoreType

    init(withRelationshipApiClient relationshipApiClient: RelationshipApiClientType, coreDataStore: CoreDataStoreType) {
        self.relationshipApiClient = relationshipApiClient
        self.coreDataStore = coreDataStore
    }
}
