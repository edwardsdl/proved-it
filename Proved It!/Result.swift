//
//  Result.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

final class Result: NSManagedObject {

}

extension Result: JSONConvertible {
    convenience init(withJSON json: JSON, insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        self.init(insertIntoManagedObjectContext: managedObjectContext)

        date = NSDateFormatter.dateFromUtcString(json["date"].string ?? "")
        message = json["message"].string
    }

    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        // dictionary["date"] = date
        dictionary["message"] = message

        return dictionary
    }
}
