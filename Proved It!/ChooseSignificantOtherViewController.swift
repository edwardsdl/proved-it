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
    func chooseSignificantOtherViewController(chooseSignificantotherViewController: ChooseSignificantOtherViewController, didFinishWithUser user: User)
}

final class ChooseSignificantOtherViewController: BaseViewController<ChooseSignificantOtherView> {

    weak var delegate: ChooseSignificantOtherViewControllerDelegate?

    private var chooseSignificantOtherDataSource: ChooseSignificantOtherDataSource?
    private var chooseSignificantOtherDelegate: ChooseSignificantOtherDelegate?

    override func loadView() {
        super.loadView()

        let contacts = loadContacts()
        chooseSignificantOtherDataSource = ChooseSignificantOtherDataSource(withContacts: contacts)
        chooseSignificantOtherDelegate = ChooseSignificantOtherDelegate(withContacts: contacts, selectionHandler: selectionHandler)

        customView.tableView.dataSource = chooseSignificantOtherDataSource
        customView.tableView.delegate = chooseSignificantOtherDelegate
    }

    private func loadContacts() -> [CNContact] {
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactPhoneNumbersKey]
        let contactFetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)

        let contactStore = CNContactStore()

        var contacts = [CNContact]()

        _ = try? contactStore.enumerateContactsWithFetchRequest(contactFetchRequest, usingBlock: { (contact, stop) in
            contacts.append(contact)
        })

        return contacts
    }

    private func selectionHandler(contact: CNContact) {
        
    }
}
