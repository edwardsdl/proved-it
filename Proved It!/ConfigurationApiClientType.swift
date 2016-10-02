//
//  ConfigurationApiClientType.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/21/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

protocol ConfigurationApiClientType {
    func delete(configuration: Configuration)
    func get()
    func patch()
    func post(configuration: Configuration)
    func put(configuration: Configuration)
}
