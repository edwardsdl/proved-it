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
        guard user.name?.characters.count > 0 else {
            delegate?.enterNameViewController(self, didEncounter: ValidationError.Required(field: "Name"))
            
            return true
        }
        
        guard let _ = try? managedObjectContext.save() else {
            delegate?.enterNameViewController(self, didEncounter: CoreDataError.FailedToSave(entity: String(user.dynamicType)))
            
            return true
        }
        
        delegate?.enterNameViewController(self, didFinishWithUser: user)

        textField.resignFirstResponder()

        return true
    }
}
