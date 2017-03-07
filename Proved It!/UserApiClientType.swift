//
//  UserApiClientType.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

protocol UserApiClientType {
    func delete(user: User)
    func get()
    func patch()
    func post(user: User)
    func put(user: User)
}
