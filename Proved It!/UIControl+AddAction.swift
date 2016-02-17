//
//  UIControl+AddAction.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/16/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol ControlActionable { }

private class ControlAction<T> {
    private let action: T -> Void

    init(withAction action: T -> Void) {
        self.action = action
    }

    func action(sender: T) {
        action(sender)
    }
}

extension ControlActionable where Self: UIControl {
    func addAction(action: Self -> Void, forControlEvents controlEvents: UIControlEvents) {
        let controlAction = ControlAction(withAction: action)

        objc_setAssociatedObject(self, Constants.AssociatedObjectKeys.ControlAction, controlAction, .OBJC_ASSOCIATION_RETAIN)

        addTarget(controlAction, action: "action:", forControlEvents: controlEvents)
    }
}

extension UIControl: ControlActionable { }
