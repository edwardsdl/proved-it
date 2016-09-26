//
//  Array.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

extension Array {
    mutating func remove(predicate: (Element) throws -> Bool) rethrows {
        guard let index = try index(where: predicate) else {
            return
        }
        
        self.remove(at: index)
    }
}

extension Array where Element: Hashable {
    func distinct() -> [Element] {
        return Array(Set(self))
    }
}
