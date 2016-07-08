//
//  SettingsDelegate.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/8/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class SettingsDelegate: NSObject, UITableViewDelegate {
    init(selectionHandler: NSIndexPath -> Void) {
        
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        guard indexPath.row < contacts.count else {
//            return
//        }
//        
//        selectionHandler(contacts[indexPath.row])
    }
}
