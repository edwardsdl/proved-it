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
    func enterNameViewController(enterNameViewController: EnterNameViewController, didFinishWithUser user: User)
}

final class EnterNameViewController: BaseViewController<EnterNameView>, UITextFieldDelegate {
    weak var delegate: EnterNameViewControllerDelegate?

    private let managedObjectContext: NSManagedObjectContext
    private let user: User

    init(withManagedObjectContext managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.user = User(insertIntoManagedObjectContext: managedObjectContext)
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
        managedObjectContext.performBlockAndWait({
            _ = try? self.managedObjectContext.save()
        })
        
        delegate?.enterNameViewController(self, didFinishWithUser: user)

        textField.resignFirstResponder()

        return true
    }
}
