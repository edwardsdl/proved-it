//
//  ChooseSignificantOtherDataSource.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/17/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Contacts
import UIKit

final class ChooseSignificantOtherDataSource: NSObject, UITableViewDataSource {
    private let contacts: [CNContact]

    init(withContacts contacts: [CNContact]) {
        self.contacts = contacts
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(String(ChooseSignificantOtherCell), forIndexPath: indexPath)
    }
}
