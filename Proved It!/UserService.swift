//
//  UserService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

final class UserService {
    let userApiClient: UserApiClientType
    let coreDataStore: CoreDataStoreType

    init(withUserApiClient userApiClient: UserApiClientType, coreDataStore: CoreDataStoreType) {
        self.userApiClient = userApiClient
        self.coreDataStore = coreDataStore
    }

    func createUser(user: User) {

    }
}
