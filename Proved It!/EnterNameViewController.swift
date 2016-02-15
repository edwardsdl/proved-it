//
//  EnterNameViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class EnterNameViewController: BaseViewController<EnterNameView> {
    override func viewDidLoad() {
        customView.nameTextField.becomeFirstResponder()
        customView.nameTextField.addTarget(self, action: "nameTextFieldEdited:", forControlEvents: .EditingChanged)
    }

    dynamic private func nameTextFieldEdited(sender: UITextField) {
        print(sender.text)
    }
}
