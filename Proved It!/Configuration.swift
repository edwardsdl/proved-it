//
//  Configuration.swift
//  Proved It!
//
//  Created by Dallas Edwards on 5/4/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

final class Configuration: BaseEntity {
    @NSManaged var time: NSNumber?
    @NSManaged var users: NSSet?
}
