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
    @NSManaged var name: String
    @NSManaged var phoneNumber: String
    @NSManaged var configuration: Configuration?
    @NSManaged var losses: Set<Result>
    @NSManaged var wins: Set<Result>
    @NSManaged var isCurrentUser: Bool
    @NSManaged var isLoggedIn: Bool
    
    var significantOther: User? {
        get {
            return configuration?.users.filter({ $0 !== self }).first
        }
        
        set {
            if let newValue = newValue {
                configuration?.users = Set([self, newValue])
            } else {
                configuration?.users = Set([self])
            }
        }
    }
}

extension User: JSONConvertible {
    convenience init(with json: JSON, insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        self.init(insertedInto: managedObjectContext)

        name = json["name"].string ?? ""
        configuration = Configuration(insertedInto: managedObjectContext)
    }

    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["name"] = name

        return dictionary
    }
}

extension NSManagedObjectContext {
    func fetchCurrentUser() -> User? {
        var user: User?
        performAndWait({ [unowned self] in
            let predicate = NSPredicate(format: "isCurrentUser = YES")
            
            let fetchRequest = User.fetchRequest()
            fetchRequest.predicate = predicate
            
            do {
                user = try self.fetch(fetchRequest).first as? User
            } catch {
                user = nil
            }
        })
        
        return user
    }
    
    func fetchUser(with phoneNumber: String, completionHandler: @escaping (Either<User?, Error>) -> Void) {
        perform({ [unowned self] in
            let predicate = NSPredicate(format: "phoneNumber = %@", phoneNumber)
    
            let fetchRequest = NSFetchRequest<User>(entityName: String(describing: User.self))
            fetchRequest.predicate = predicate
    
            do {
                let objects = try self.fetch(fetchRequest)
                let users = objects.flatMap({ $0 })
                let user = users.first
                
                completionHandler(.left(user))
            } catch {
                completionHandler(.right(error))
            }
        })
    }
}

