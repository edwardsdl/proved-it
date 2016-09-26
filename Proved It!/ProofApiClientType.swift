//
//  ProofApiClientType.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

protocol ResultApiClientType {
    func delete(_ result: Result)
    func get()
    func patch()
    func post(_ result: Result)
    func put(_ result: Result)
}
