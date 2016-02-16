//
//  EnterNameViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol EnterNameViewControllerDelegate:class {
    func enterNameViewControllerDidEnterName(enterNameViewController: EnterNameViewController)
}

final class EnterNameViewController: BaseViewController<EnterNameView>, UITextFieldDelegate {
    weak var delegate: EnterNameViewControllerDelegate?

    override func viewDidLoad() {
        customView.nameTextField.addTarget(self, action: "nameTextFieldEditingChanged:", forControlEvents: .EditingChanged)
        customView.nameTextField.becomeFirstResponder()
        customView.nameTextField.delegate = self
    }

    dynamic private func nameTextFieldEditingChanged(sender: UITextField) {

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.enterNameViewControllerDidEnterName(self)

        textField.resignFirstResponder()

        return true
    }
}
