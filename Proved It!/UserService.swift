//
//  UserService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

final class UserService {
    let userApiClient: UserApiClientType
    let managedObjectContext: NSManagedObjectContext

    init(withUserApiClient userApiClient: UserApiClientType, managedObjectContext: NSManagedObjectContext) {
        self.userApiClient = userApiClient
        self.managedObjectContext = managedObjectContext
    }

    func createUser(user: User) {

    }
}
