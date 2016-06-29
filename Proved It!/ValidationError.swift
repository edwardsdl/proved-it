//
//  ValidationError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Foundation

enum ValidationError: ErrorType {
    case Other(message: String)
    case Required(field: String)
    case TooLong(field: String, maximumLength: Int)
    case TooShort(field: String, minimumLength: Int)
    
    var message: String {
        switch self {
        case .Other(let message):
            return message
        case .Required(let field):
            return "\(field) is required"
        case .TooShort(let field, let minimumLength):
            return "\(field) must be at least \(minimumLength) characters"
        case .TooLong(let field, let maximumLength):
            return "\(field) must be fewer than \(maximumLength) characters"
        }
    }
}
