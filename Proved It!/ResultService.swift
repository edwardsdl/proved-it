//
//  ResultService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

final class ResultService {
    let resultApiClient: ResultApiClientType
    let coreDataStore: CoreDataStack

    init(withResultApiClient resultApiClient: ResultApiClientType, coreDataStore: CoreDataStoreType) {
        self.resultApiClient = resultApiClient
        self.coreDataStore = coreDataStore
    }
}
