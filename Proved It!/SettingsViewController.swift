//
//  SettingsViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/7/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class SettingsViewController: BaseViewController<SettingsView> {
    private let user: User
    
    init(with user: User) {
        self.user = user
        
        super.init()
        
        title = "Settings"
    }
    
    override func viewDidLoad() {
        let settingsDataSource = SettingsDataSource()
        let settingsDelegate = SettingsDelegate(selectionHandler: { _ in })
        
        customView.configure(with: settingsDataSource, settingsDelegate: settingsDelegate)
    }
}
