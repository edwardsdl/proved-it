//
//  Relationship.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

final class Relationship: NSManagedObject {

}

extension Relationship: JSONConvertible {
    convenience init(withJSON json: JSON, insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        self.init(insertIntoManagedObjectContext: managedObjectContext)

        time = json["time"].double
    }

    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["time"] = time

        return dictionary
    }
}
