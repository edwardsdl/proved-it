//
//  CoreDataError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

enum CoreDataError: ErrorType {
    case UnableToInitializeManagedObjectModel
    case UnableToInitializePersistentStore
    case UnableToSave
}