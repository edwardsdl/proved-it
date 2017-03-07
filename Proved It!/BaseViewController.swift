//
//  BaseViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    var customView: T {
        guard let customView = view as? T else {
            preconditionFailure("Expected to find view of type \(String(describing: T.self))")
        }

        return customView
    }
}
