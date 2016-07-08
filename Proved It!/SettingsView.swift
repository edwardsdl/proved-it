//
//  SettingsView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/7/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class SettingsView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    
    private var settingsDataSource: SettingsDataSource?
    private var settingsDelegate: SettingsDelegate?
    
    override func awakeFromNib() {
        configureTableView()
        configureRegisteredCells()
        configureSignOutButton()
    }
    
    func configure(with settingsDataSource: SettingsDataSource, settingsDelegate: SettingsDelegate) {
        self.settingsDataSource = settingsDataSource
        self.settingsDelegate = settingsDelegate
        
        tableView.dataSource = settingsDataSource
        tableView.delegate = settingsDelegate
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        tableView.tableFooterView = UIView()
    }
    
    private func configureRegisteredCells() {
        let settingsCellName = String(SettingsCell)
        let settingsCellNib = UINib(nibName: String(SettingsCell), bundle: nil)
        
        let settingsTextFieldCellName = String(SettingsTextFieldCell)
        let settingsTextFieldCellNib = UINib(nibName: settingsTextFieldCellName, bundle: nil)
        
        tableView.registerNib(settingsCellNib, forCellReuseIdentifier: settingsCellName)
        tableView.registerNib(settingsTextFieldCellNib, forCellReuseIdentifier: settingsTextFieldCellName)
    }
    
    private func configureSignOutButton() {
        signOutButton.layer.borderColor = UIColor.provedItOrangeColor().colorWithAlphaComponent(0.2).CGColor
        signOutButton.layer.borderWidth = 1
    }
}
