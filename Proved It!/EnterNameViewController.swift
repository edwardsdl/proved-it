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
    func enterNameViewController(_ enterNameViewController: EnterNameViewController, didFinishWith user: User)
    func enterNameViewController(_ enterNameViewController: EnterNameViewController, didEncounter error: Error)
}

final class EnterNameViewController: BaseViewController<EnterNameView>, UITextFieldDelegate {
    weak var delegate: EnterNameViewControllerDelegate?

    private var user: User!

    func configure(with user: User) {
        self.user = user
    }

    override func viewDidLoad() {
        // TODO: This should use the delegate pattern
        customView.nameTextField.addTarget(self, action: #selector(EnterNameViewController.nameTextFieldEditingChanged(_:)), for: .editingChanged)
        customView.nameTextField.becomeFirstResponder()
        customView.nameTextField.delegate = self
    }

    func nameTextFieldEditingChanged(_ sender: UITextField) {
        user.name = sender.text ?? ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let managedObjectContext = user.managedObjectContext else {
            delegate?.enterNameViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return true
        }
        
        managedObjectContext.save({ [unowned self] either in
            switch either {
            case .left:
                self.delegate?.enterNameViewController(self, didFinishWith: self.user)
            case .right(let error):
                self.delegate?.enterNameViewController(self, didEncounter: error)
            }
        })

        return true
    }
}
