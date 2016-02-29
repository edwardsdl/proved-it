//
//  UserApiClient.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Alamofire

final class UserApiClient: UserApiClientType {
    func delete(userModel: User) {

    }

    func get() {

    }

    func patch() {

    }

    func post(model: User) {

    }

    func put(model: User) {

    }
}

private enum UserRouter: URLRequestConvertible {
    var URLRequest: NSMutableURLRequest {
        return NSMutableURLRequest()
    }
}
