//
//  SettingsDataSource.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/8/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class SettingsDataSource: NSObject, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCellWithIdentifier(String(SettingsTextFieldCell), forIndexPath: indexPath)
        default:
            return tableView.dequeueReusableCellWithIdentifier(String(SettingsCell), forIndexPath: indexPath)
        }
    }
}
