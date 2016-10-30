//
//  ApplicationError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/2/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

enum ApplicationError: Error {
    case failedToUnwrapValue
    case other(message: String)
    
    var message: String {
        switch self {
        case .failedToUnwrapValue:
            return "An unrecoverable error occurred"
        case .other(let message):
            return message
        }
    }
}
