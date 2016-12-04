//
//  NSManagedObjectContextExtensions.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    func save(_ completionHandler: @escaping (Either<Error, Void>) -> Void) {
        perform({ [unowned self] in
            do {
                try self.save()
                
                DispatchQueue.main.async(execute: {
                    completionHandler(.right())
                })
            } catch {
                DispatchQueue.main.async(execute: {
                    completionHandler(.left(error))
                })
            }
        })
    }
}
