//
//  SettingsView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/7/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: class {
    func settingsView(_ settingsView: SettingsView, didChangeNameTo name: String)
    func settingsViewDidSelectTime(_ settingsView: SettingsView)
    func settingsViewDidSelectSignificantOther(_ settingsView: SettingsView)
    func settingsViewDidTapSignOut(_ settingsView: SettingsView)
    func settingsView(_ settingsView: SettingsView, didEncounter error: Error)
}

final class SettingsView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var signOutButton: UIButton!
    
    weak var delegate: SettingsViewDelegate?
    
    fileprivate var user: User?
    
    override func awakeFromNib() {
        configureTableView()
        configureRegisteredCells()
        configureNameTextField()
        configureSignOutButton()
    }
    
    @IBAction func signOutButtonTouchUpInside(_ sender: UIButton) {
        delegate?.settingsViewDidTapSignOut(self)
    }
    
    func configure(with user: User) {
        self.user = user
        
        tableView.reloadData()
    }
    
    fileprivate func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.2)
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func configureRegisteredCells() {
        let settingsCellName = String(describing: SettingsCell.self)
        let settingsCellNib = UINib(nibName: String(describing: SettingsCell.self), bundle: nil)
        
        let settingsTextFieldCellName = String(describing: SettingsTextFieldCell.self)
        let settingsTextFieldCellNib = UINib(nibName: settingsTextFieldCellName, bundle: nil)
        
        tableView.register(settingsCellNib, forCellReuseIdentifier: settingsCellName)
        tableView.register(settingsTextFieldCellNib, forCellReuseIdentifier: settingsTextFieldCellName)
    }
    
    fileprivate func configureNameTextField() {
        guard let settingsTextFieldCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? SettingsTextFieldCell else {
            return
        }
        
        settingsTextFieldCell.detailTextField.delegate = self
    }
    
    fileprivate func configureSignOutButton() {
        signOutButton.layer.borderColor = UIColor.provedItOrangeColor().withAlphaComponent(0.2).cgColor
        signOutButton.layer.borderWidth = 1
    }
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as NSIndexPath).row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsTextFieldCell.self), for: indexPath)
        default:
            return tableView.dequeueReusableCell(withIdentifier: String(describing: SettingsCell.self), for: indexPath)
        }
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let user = user else {
            delegate?.settingsView(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        switch cell {
        case let cell as SettingsTextFieldCell where (indexPath as NSIndexPath).row == 0:
            cell.configure(with: "Name", detail: user.name)
        case let cell as SettingsCell where (indexPath as NSIndexPath).row == 1:
            cell.configure(with: "Time", detail: user.configuration?.formattedTime ?? "")
        case let cell as SettingsCell where (indexPath as NSIndexPath).row == 2:
            cell.configure(with: "Significant Other", detail: user.significantOther?.name ?? "")
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).item {
        case 1:
            delegate?.settingsViewDidSelectTime(self)
        case 2:
            delegate?.settingsViewDidSelectSignificantOther(self)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.settingsView(self, didChangeNameTo: textField.text ?? "")
        
        return true
    }
}
