//
//  ResultService.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

final class ResultService {
    let resultApiClient: ResultApiClientType
    let managedObjectContext: NSManagedObjectContext

    init(withResultApiClient resultApiClient: ResultApiClientType, managedObjectContext: NSManagedObjectContext) {
        self.resultApiClient = resultApiClient
        self.managedObjectContext = managedObjectContext
    }
}
