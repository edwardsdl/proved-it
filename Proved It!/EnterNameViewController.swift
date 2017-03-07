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
            case .left(let error):
                self.delegate?.enterNameViewController(self, didEncounter: error)
            case .right:
                self.delegate?.enterNameViewController(self, didFinishWith: self.user)
            }
        })

        return true
    }
    
    func configure(with user: User) {
        configureNavigationItem()
        
        self.user = user
    }
    
    private func configureNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
    }
    
    @objc private func rightBarButtonItemTapped() {
        guard let user = user else {
            delegate?.enterNameViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        guard let managedObjectContext = user.managedObjectContext else {
            delegate?.enterNameViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        managedObjectContext.save({ [unowned self] either in
            switch either {
            case .left(let error):
                self.delegate?.enterNameViewController(self, didEncounter: error)
            case .right:
                self.delegate?.enterNameViewController(self, didFinishWith: user)
            }
        })
    }
}
