//
//  User.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

final class User: NSManagedObject {

}

extension User: JSONConvertible {
    convenience init(withJSON json: JSON, insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        self.init(insertIntoManagedObjectContext: managedObjectContext)

        name = json["name"].string
    }

    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["name"] = name

        return dictionary
    }
}

