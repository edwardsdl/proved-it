//
//  CoreDataError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

enum CoreDataError: Error {
    case failedToCreateManagedObjectModel
    case failedToCreatePersistentStore
    case failedToFetchCurrentUser
    case other(message: String)
    
    var message: String {
        switch self {
        case .failedToCreateManagedObjectModel:
            return "Failed to create managed object model"
        case .failedToCreatePersistentStore:
            return "Failed to create persistent store"
        case .failedToFetchCurrentUser:
            return "Failed to fetch current user"
        case .other(let message):
            return message
        }
    }
}
