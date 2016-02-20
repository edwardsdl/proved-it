//
//  ChooseSignificantOtherCell.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/18/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Contacts
import UIKit

final class ChooseSignificantOtherCell: UITableViewCell {
    func configure(withContact contact: CNContact) {
        configureTextLabel(withContact: contact)
        configureDetailTextLabel(withContact: contact)
    }

    private func configureTextLabel(withContact contact: CNContact) {
        textLabel?.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
    }

    private func configureDetailTextLabel(withContact contact: CNContact) {
        let phoneNumbers = contact.phoneNumbers.flatMap({ $0.value as? CNPhoneNumber })

        if phoneNumbers.count == 1 {
            detailTextLabel?.text = phoneNumbers.first?.stringValue
        } else {
            detailTextLabel?.text = "\(phoneNumbers.count) numbers"
        }
    }
}
