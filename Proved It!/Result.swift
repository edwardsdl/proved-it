//
//  Result.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

final class Result: BaseEntity {
    @NSManaged var date: Date
    @NSManaged var message: String
    @NSManaged var losingUser: User
    @NSManaged var winningUser: User
}

extension Result: JSONConvertible {
    convenience init(with json: JSON, insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        self.init(insertedInto: managedObjectContext)

        date = DateFormatter.dateFromUtcString(json["date"].string!)!
        message = json["message"].string ?? ""
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["date"] = DateFormatter.utcStringFromDate(date)
        dictionary["message"] = message as AnyObject?

        return dictionary
    }
}
