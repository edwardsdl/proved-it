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
    @NSManaged var date: NSDate?
    @NSManaged var message: String?
    @NSManaged var losingUser: User?
    @NSManaged var winningUser: User?
}

extension Result: JSONConvertible {
    convenience init(withJSON json: JSON, insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        self.init(insertIntoManagedObjectContext: managedObjectContext)

        date = NSDateFormatter.dateFromUtcString(json["date"].string ?? "")
        message = json["message"].string
    }

    func toDictionary() -> [String: AnyObject] {
        guard let date = date else {
            preconditionFailure("Failed to unwrap date")
        }
        
        var dictionary = [String: AnyObject]()
        dictionary["date"] = NSDateFormatter.utcStringFromDate(date)
        dictionary["message"] = message

        return dictionary
    }
}
