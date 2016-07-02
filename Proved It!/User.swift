//
//  User.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

final class User: BaseEntity {

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

extension NSManagedObjectContext {
    func fetchUser(with phoneNumber: String, completionHandler: (Either<User?, ErrorType>) -> Void) {
        performBlock({ [unowned self] in
            let predicate = NSPredicate(format: "phoneNumber = %@", phoneNumber)
    
            let fetchRequest = NSFetchRequest(entityName: String(User))
            fetchRequest.predicate = predicate
    
            do {
                let objects = try self.executeFetchRequest(fetchRequest)
                let users = objects.flatMap({ $0 as? User })
                let user = users.first
                
                completionHandler(.Left(user))
            } catch {
                completionHandler(.Right(error))
            }
        })
    }
}

