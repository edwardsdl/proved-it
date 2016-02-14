//
//  CoreDataError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Foundation

enum CoreDataError: ErrorType {
    case ManagedObjectContext(description: String)
    case PersistentStore(description: String)

    var description: String {
        switch self {
        case .ManagedObjectContext(let description):
            return description
        case .PersistentStore(let description):
            return description
        }
    }

    var localizedRecoverySuggestion: String {
        return NSLocalizedString("CoreDataError", comment: "")
    }
}