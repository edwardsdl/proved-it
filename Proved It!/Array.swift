//
//  Array.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

extension Array {
    mutating func remove(@noescape predicate: (Element) throws -> Bool) rethrows {
        guard let index = try indexOf(predicate) else {
            return
        }
        
        removeAtIndex(index)
    }
}

extension Array where Element: Hashable {
    @warn_unused_result func distinct() -> [Element] {
        return Array(Set(self))
    }
}
