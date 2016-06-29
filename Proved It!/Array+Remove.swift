//
//  Array+Remove.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

extension Array {
    mutating func remove(@noescape predicate: (Generator.Element) throws -> Bool) rethrows {
        guard let index = try indexOf(predicate) else {
            return
        }
        
        removeAtIndex(index)
    }
}
