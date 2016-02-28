//
//  UserModel.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

final class UserModel {
    var name: String?
    var phoneNumber: String?
}

extension UserModel: JSONConvertible {
    convenience init(withJSON json: JSON) {
        self.init()

        name = json["name"].string
        phoneNumber = json["phoneNumber"].string
    }

    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
        dictionary["name"] = name
        dictionary["phoneNumber"] = phoneNumber

        return dictionary
    }
}

extension UserModel: ManagedObjectConvertible {
    typealias T = UserEntity

    convenience init(withManagedObject managedObject: T) {
        self.init()

        name = managedObject.name
        phoneNumber = managedObject.phoneNumber
    }

    func toManagedObject(insertIntoManagedObjectContext managedObjectContext: NSManagedObjectContext) -> T {
        let managedObject = UserEntity(insertIntoManagedObjectContext: managedObjectContext)
        managedObject.name = name
        managedObject.phoneNumber = phoneNumber

        return managedObject
    }
}

extension UserModel: Validatable {
    func isValid() -> Bool {
        return true
    }
}
