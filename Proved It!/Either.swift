//
//  Either.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/26/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

enum Either<T, U> {
    case left(T)
    case right(U)
}
