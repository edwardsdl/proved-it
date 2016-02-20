//
//  ChooseSignificantOtherDelegate.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/17/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Contacts
import UIKit

final class ChooseSignificantOtherDelegate: NSObject, UITableViewDelegate {
    private let contacts: [CNContact]

    init(withContacts contacts: [CNContact]) {
        self.contacts = contacts
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? ChooseSignificantOtherCell {
            cell.configure(withContact: contacts[indexPath.row])
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
