//
//  ProofApiClientType.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

protocol ProofApiClientType {
    func delete(userModel: ProofModel)
    func get()
    func patch()
    func post(model: ProofModel)
    func put(model: ProofModel)
}
