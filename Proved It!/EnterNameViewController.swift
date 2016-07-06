//
//  EnterNameViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol EnterNameViewControllerDelegate: class {
    func enterNameViewController(enterNameViewController: EnterNameViewController, didEncounter error: ErrorType)
    func enterNameViewController(enterNameViewController: EnterNameViewController, didFinishWithUser user: User)
}

final class EnterNameViewController: BaseViewController<EnterNameView>, UITextFieldDelegate {
    weak var delegate: EnterNameViewControllerDelegate?

    private let user: User

    init(with user: User) {
        self.user = user
    }

    override func viewDidLoad() {
        customView.nameTextField.addTarget(self, action: #selector(EnterNameViewController.nameTextFieldEditingChanged(_:)), forControlEvents: .EditingChanged)
        customView.nameTextField.becomeFirstResponder()
        customView.nameTextField.delegate = self
    }

    func nameTextFieldEditingChanged(sender: UITextField) {
        user.name = sender.text
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        user.managedObjectContext?.save({ [unowned self] either in
            switch either {
            case .Left:
                self.delegate?.enterNameViewController(self, didFinishWithUser: self.user)
            case .Right(let error):
                self.delegate?.enterNameViewController(self, didEncounter: error)
            }
        })

        return true
    }
}
