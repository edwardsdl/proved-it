//
//  JSONConvertible.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

protocol JSONConvertible {
    init(with json: JSON, insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext)
    func toDictionary() -> [String: Any]
}
