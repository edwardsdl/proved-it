//
//  RelationshipApiClient.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Alamofire

final class RelationshipApiClient: RelationshipApiClientType {
    func delete(relationship: Relationship) {

    }

    func get() {

    }

    func patch() {

    }

    func post(relationshipModel: Relationship) {

    }

    func put(relationshipModel: Relationship) {

    }
}

private enum RelationshipRouter: URLRequestConvertible {
    var URLRequest: NSMutableURLRequest {
        return NSMutableURLRequest()
    }
}
