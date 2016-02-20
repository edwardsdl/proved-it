//
//  ChooseSignificantOtherViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/17/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Contacts
import UIKit

final class ChooseSignificantOtherViewController: BaseViewController<ChooseSignificantOtherView> {
    private var chooseSignificantOtherDataSource: ChooseSignificantOtherDataSource?
    private var chooseSignificantOtherDelegate: ChooseSignificantOtherDelegate?

    override func loadView() {
        super.loadView()

        let contacts = loadContacts()
        chooseSignificantOtherDataSource = ChooseSignificantOtherDataSource(withContacts: contacts)
        chooseSignificantOtherDelegate = ChooseSignificantOtherDelegate(withContacts: contacts)

        customView.tableView.dataSource = chooseSignificantOtherDataSource
        customView.tableView.delegate = chooseSignificantOtherDelegate
    }

    private func loadContacts() -> [CNContact] {
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactPhoneNumbersKey]
        let contactFetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)

        let contactStore = CNContactStore()
        var contacts = [CNContact]()
        try! contactStore.enumerateContactsWithFetchRequest(contactFetchRequest, usingBlock: { (contact, stop) -> Void in
            contacts.append(contact)
        })

        return contacts
    }
}
