//
//  NSManagedObjectContextExtensions.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    func save(completionHandler: (Either<Void, ErrorType>) -> Void) {
        performBlock({ [unowned self] in
            do {
                try self.save()
                
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(.Left())
                })
            } catch {
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(.Right(error))
                })
            }
        })
    }
}
