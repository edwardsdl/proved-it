//
//  NSBundle+LoadView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

extension Bundle {
    func loadView<T: UIView>(fromNibNamed name: String, owner: AnyObject) -> T {
        let objects = loadNibNamed(name, owner: owner, options: nil)
        if let view = objects?.filter({ $0 is T }).first as? T {
            return view
        } else {
            preconditionFailure("Unable to load view of type \(NSStringFromClass(T.self)) from nib named \(name)")
        }
    }
}
