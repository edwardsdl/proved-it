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
            preconditionFailure("Expected to find view of type \(String(T))")
        }

        return customView
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        let bundle = NSBundle.mainBundle()
        let view = bundle.loadView(fromNibNamed: String(T), owner: self) as T

        self.view = view
    }
}
