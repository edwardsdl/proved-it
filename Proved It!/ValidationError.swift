//
//  ValidationError.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Foundation

enum ValidationError: Error {
    case other(message: String)
    case required(field: String)
    case tooLong(field: String, maximumLength: Int)
    case tooShort(field: String, minimumLength: Int)
    
    var message: String {
        switch self {
        case .other(let message):
            return message
        case .required(let field):
            return "\(field) is required"
        case .tooShort(let field, let minimumLength):
            return "\(field) must be at least \(minimumLength) characters"
        case .tooLong(let field, let maximumLength):
            return "\(field) must be fewer than \(maximumLength) characters"
        }
    }
}
