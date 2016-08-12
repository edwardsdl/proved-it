//
//  SettingsView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/7/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: class {
    func settingsView(settingsView: SettingsView, didChangeNameTo name: String)
    func settingsViewDidSelectTime(settingsView: SettingsView)
    func settingsViewDidSelectSignificantOther(settingsView: SettingsView)
    func settingsViewDidTapSignOut(settingsView: SettingsView)
    func settingsView(settingsView: SettingsView, didEncounter error: ErrorType)
}

final class SettingsView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    
    weak var delegate: SettingsViewDelegate?
    
    private var user: User?
    
    override func awakeFromNib() {
        configureTableView()
        configureRegisteredCells()
        configureNameTextField()
        configureSignOutButton()
    }
    
    @IBAction func signOutButtonTouchUpInside(sender: UIButton) {
        delegate?.settingsViewDidTapSignOut(self)
    }
    
    func configure(with user: User) {
        self.user = user
        
        tableView.reloadData()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
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
    
    private func configureNameTextField() {
        guard let settingsTextFieldCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as? SettingsTextFieldCell else {
            return
        }
        
        settingsTextFieldCell.detailTextField.delegate = self
    }
    
    private func configureSignOutButton() {
        signOutButton.layer.borderColor = UIColor.provedItOrangeColor().colorWithAlphaComponent(0.2).CGColor
        signOutButton.layer.borderWidth = 1
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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

extension SettingsView: UITableViewDelegate {
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        switch cell {
        case let cell as SettingsTextFieldCell where indexPath.row == 0:
            cell.configure(with: "Name", detail: user?.name ?? "")
        case let cell as SettingsCell where indexPath.row == 1:
            cell.configure(with: "Time", detail: user?.configuration?.time?.stringValue ?? "")
        case let cell as SettingsCell where indexPath.row == 2:
            cell.configure(with: "Significant Other", detail: user?.configuration?.users?.allObjects.last?.name ?? "")
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.item {
        case 1:
            delegate?.settingsViewDidSelectTime(self)
        case 2:
            delegate?.settingsViewDidSelectSignificantOther(self)
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension SettingsView: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        delegate?.settingsView(self, didChangeNameTo: textField.text ?? "")
        
        return true
    }
}
