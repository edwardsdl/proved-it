//
//  CoreDataError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

enum CoreDataError: ErrorType {
    case FailedToCreateManagedObjectModel
    case FailedToCreatePersistentStore
    case Other(message: String)
    
    var message: String {
        switch self {
        case .FailedToCreateManagedObjectModel:
            return "Failed to create managed object model"
        case .FailedToCreatePersistentStore:
            return "Failed to create persistent store"
        case .Other(let message):
            return message
        }
    }
}