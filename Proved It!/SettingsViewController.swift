//
//  SettingsViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/7/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerDidSelectTime(settingsViewController: SettingsViewController)
    func settingsViewControllerDidSelectSignificantOther(settingsViewController: SettingsViewController)
    func settingsViewControllerDidTapSignOut(settingsViewController: SettingsViewController)
    func settingsViewController(settingsViewController: SettingsViewController, didEncounter error: ErrorType)
}

final class SettingsViewController: BaseViewController<SettingsView> {
    weak var delegate: SettingsViewControllerDelegate?
    
    private let user: User
    
    init(with user: User) {
        self.user = user
        
        super.init()
        
        title = "Settings"
    }
    
    override func viewDidLoad() {
        customView.delegate = self
        customView.configure(with: user)
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func settingsView(settingsView: SettingsView, didChangeNameTo name: String) {
        user.managedObjectContext?.save({ [unowned self] either in
            if case .Right(let error) = either {
                self.delegate?.settingsViewController(self, didEncounter: error)
            }
        })
    }
    
    func settingsViewDidSelectTime(settingsView: SettingsView) {
        delegate?.settingsViewControllerDidSelectTime(self)
    }
    
    func settingsViewDidSelectSignificantOther(settingsView: SettingsView) {
        delegate?.settingsViewControllerDidSelectSignificantOther(self)
    }
    
    func settingsViewDidTapSignOut(settingsView: SettingsView) {
        delegate?.settingsViewControllerDidTapSignOut(self)
    }
}
