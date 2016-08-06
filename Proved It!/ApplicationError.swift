//
//  ApplicationError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/2/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

enum ApplicationError: ErrorType {
    case FailedToUnwrapValue
    case Other(message: String)
    
    var message: String {
        switch self {
        case .Other(let message):
            return message
        default:
            return "An unrecoverable error occurred"
        }
    }
}
