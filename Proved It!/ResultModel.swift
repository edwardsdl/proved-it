//
//  ResultModel.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import SwiftyJSON

final class ResultModel {
    var date: NSDate?
    var message: String?
}

extension ResultModel: JSONConvertible {
    convenience init(withJSON json: JSON) {
        self.init()

//        date = json["date"].string
        message = json["message"].string
    }

    func toDictionary() -> [String: AnyObject] {
        var dictionary = [String: AnyObject]()
//        dictionary["date"] = date
        dictionary["message"] = message

        return dictionary
    }
}

extension ResultModel: Validatable {
    func isValid() -> Bool {
        return true
    }
}
