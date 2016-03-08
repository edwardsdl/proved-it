//
//  EnterNameViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol EnterNameViewControllerDelegate: class {
    func enterNameViewController(enterNameViewController: EnterNameViewController, didFinishWithUser user: User)
}

final class EnterNameViewController: BaseViewController<EnterNameView>, UITextFieldDelegate {
    weak var delegate: EnterNameViewControllerDelegate?

    private let coreDataStore: CoreDataStoreType
    private let user: User

    init(withCoreDataStore coreDataStore: CoreDataStoreType) {
        self.coreDataStore = coreDataStore
        self.user = User(insertIntoManagedObjectContext: coreDataStore.managedObjectContext)
    }

    override func viewDidLoad() {
        customView.nameTextField.addTarget(self, action: "nameTextFieldEditingChanged:", forControlEvents: .EditingChanged)
        customView.nameTextField.becomeFirstResponder()
        customView.nameTextField.delegate = self
    }

    func nameTextFieldEditingChanged(sender: UITextField) {
        user.name = sender.text
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.enterNameViewController(self, didFinishWithUser: user)

        textField.resignFirstResponder()

        return true
    }
}
