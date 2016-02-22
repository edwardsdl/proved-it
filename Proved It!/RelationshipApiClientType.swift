//
//  RelationshipApiClientType.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

protocol RelationshipApiClientType {
    func delete(userModel: RelationshipModel)
    func get()
    func patch()
    func post(model: RelationshipModel)
    func put(model: RelationshipModel)
}
