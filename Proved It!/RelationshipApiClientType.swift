//
//  RelationshipApiClientType.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

protocol RelationshipApiClientType {
    func delete(userModel: Relationship)
    func get()
    func patch()
    func post(model: Relationship)
    func put(model: Relationship)
}
