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
    func chooseSignificantOtherViewControllerDidSelectSignificantOther(chooseSignificantOtherViewController: ChooseSignificantOtherViewController)
    func chooseSignificantOtherViewController(chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didSelectSignificantOtherWith name: String, phoneNumbers: [String])
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
        
        customView.delegate = self
        customView.configure(using: loadContacts())
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
            delegate?.chooseSignificantOtherViewControllerDidSelectSignificantOther(self)
        case let count where count > 1:
            delegate?.chooseSignificantOtherViewController(self, didSelectSignificantOtherWith: name, phoneNumbers: Array(phoneNumbers.prefix(5)))
        default:
            delegate?.chooseSignificantOtherViewController(self, didEncounter: ApplicationError.Other(message: "Received unexpected number of phone numbers"))
        }
    }
}
