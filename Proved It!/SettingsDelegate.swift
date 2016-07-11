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
        switch cell {
        case let cell as SettingsTextFieldCell where indexPath.row == 0:
            cell.configure(with: "Name", detail: "Dallas Edwards")
        case let cell as SettingsCell where indexPath.row == 1:
            cell.configure(with: "Phone Number", detail: "+18049285174")
        case let cell as SettingsCell where indexPath.row == 2:
            cell.configure(with: "Time", detail: "16:53")
        case let cell as SettingsCell where indexPath.row == 3:
            cell.configure(with: "Significant Other", detail: "Cierra Edwards")
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
