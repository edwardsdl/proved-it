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
    func chooseSignificantOtherViewController(_ chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didFinishWith user: User)
    func chooseSignificantOtherViewController(_ chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didEncounter error: Error)
}

final class ChooseSignificantOtherViewController: BaseViewController<ChooseSignificantOtherView> {
    weak var delegate: ChooseSignificantOtherViewControllerDelegate?

    fileprivate var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contacts = loadContacts()
        
        customView.delegate = self
        customView.configure(using: contacts)
    }
    
    func configure(with user: User) {
        self.user = user
    }

    private func loadContacts() -> [CNContact] {
        var contacts = [CNContact]()

        do {
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
            let contactFetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
            
            let contactStore = CNContactStore()
            try contactStore.enumerateContacts(with: contactFetchRequest, usingBlock: { (contact, stop) in
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
    func chooseSignificantOtherView(_ chooseSignificantOtherView: ChooseSignificantOtherView, didChooseContactWith name: String, phoneNumbers: [String]) {
        switch phoneNumbers.count {
        case 1:
            save(usingContactWith: name, phoneNumber: phoneNumbers[0])
        case let count where count > 1:
            promptUserForPhoneNumber(forContactWith: name, phoneNumbers: phoneNumbers)
        default:
            delegate?.chooseSignificantOtherViewController(self, didEncounter: ApplicationError.other(message: "Received unexpected number of phone numbers"))
        }
    }
    
    private func promptUserForPhoneNumber(forContactWith name: String, phoneNumbers: [String]) {
        let phoneNumbers = phoneNumbers.prefix(5)
        
        let alertController = UIAlertController(title: "Choose a phone number for \(name)", message: nil, preferredStyle: .actionSheet)
        
        var alertActions = phoneNumbers.map({
            UIAlertAction(title: "\($0)", style: .default, handler: { [weak self] in
                self?.save(usingContactWith: name, phoneNumber: $0.title ?? "")
            })
        })
        alertActions.append(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertActions.forEach({ alertController.addAction($0) })
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func save(usingContactWith name: String, phoneNumber: String) {
        guard let user = user else {
            delegate?.chooseSignificantOtherViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        guard let managedObjectContext = user.managedObjectContext else {
            delegate?.chooseSignificantOtherViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        user.significantOther = User(insertedInto: managedObjectContext)
        user.significantOther?.name = name
        user.significantOther?.phoneNumber = phoneNumber
        
        managedObjectContext.save({ [unowned self] either in
            switch either {
            case .left:
                self.delegate?.chooseSignificantOtherViewController(self, didFinishWith: user)
            case .right(let error):
                self.delegate?.chooseSignificantOtherViewController(self, didEncounter: error)
            }
        })
    }
}
