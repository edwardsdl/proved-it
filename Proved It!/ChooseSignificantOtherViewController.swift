//
//  ChooseSignificantOtherViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/17/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Contacts
import UIKit

protocol ChooseSignificantOtherViewControllerDelegate: class {
    func chooseSignificantOtherViewController(chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didFinishWith user: User)
    func chooseSignificantOtherViewController(chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didEncounter error: ErrorType)
}

final class ChooseSignificantOtherViewController: BaseViewController<ChooseSignificantOtherView> {
    weak var delegate: ChooseSignificantOtherViewControllerDelegate?

    private let user: User

    init(with user: User) {
        self.user = user
        
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contacts = loadContacts()
        
        customView.delegate = self
        customView.configure(using: contacts)
    }

    private func loadContacts() -> [CNContact] {
        var contacts = [CNContact]()

        do {
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactPhoneNumbersKey]
            let contactFetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
            
            let contactStore = CNContactStore()
            try contactStore.enumerateContactsWithFetchRequest(contactFetchRequest, usingBlock: { (contact, stop) in
                guard contact.phoneNumbers.count > 0 else {
                    return
                }
                
                contacts.append(contact)
            })
        } catch {
            delegate?.chooseSignificantOtherViewController(self, didEncounter: error)
        }

        return contacts
    }
}

extension ChooseSignificantOtherViewController: ChooseSignificantOtherViewDelegate {
    func chooseSignificantOtherView(chooseSignificantOtherView: ChooseSignificantOtherView, didChooseContactWith name: String, phoneNumbers: [String]) {
        switch phoneNumbers.count {
        case 1:
            save(usingContactWith: name, phoneNumber: phoneNumbers[0])
        case let count where count > 1:
            promptUserForPhoneNumber(forContactWith: name, phoneNumbers: phoneNumbers)
        default:
            delegate?.chooseSignificantOtherViewController(self, didEncounter: ApplicationError.Other(message: "Received unexpected number of phone numbers"))
        }
    }
    
    private func promptUserForPhoneNumber(forContactWith name: String, phoneNumbers: [String]) {
        let alertController = UIAlertController(title: "Choose a phone number for \(name)", message: nil, preferredStyle: .ActionSheet)
        
        var alertActions = phoneNumbers.prefix(5).map({
            UIAlertAction(title: "\($0)", style: .Default, handler: {
                [weak self] in self?.save(usingContactWith: name, phoneNumber: $0.title ?? "")
            })
        })
        alertActions.append(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alertActions.forEach({ alertController.addAction($0) })
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func save(usingContactWith name: String, phoneNumber: String) {
        guard let managedObjectContext = user.managedObjectContext else {
            delegate?.chooseSignificantOtherViewController(self, didEncounter: ApplicationError.FailedToUnwrapValue)
            
            return
        }
        
        user.significantOther = User(insertedInto: managedObjectContext)
        user.significantOther?.name = name
        user.significantOther?.phoneNumber = phoneNumber
        
        managedObjectContext.save({ [unowned self] either in
            switch either {
            case .Left:
                self.delegate?.chooseSignificantOtherViewController(self, didFinishWith: self.user)
            case .Right(let error):
                self.delegate?.chooseSignificantOtherViewController(self, didEncounter: error)
            }
        })
    }
}
