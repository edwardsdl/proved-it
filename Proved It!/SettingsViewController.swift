//
//  SettingsViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/7/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import DigitsKit
import UIKit

protocol SettingsViewControllerDelegate: class {
    func settingsViewControllerDidSelectTime(_ settingsViewController: SettingsViewController)
    func settingsViewControllerDidSelectSignificantOther(_ settingsViewController: SettingsViewController)
    func settingsViewControllerDidTapSignOut(_ settingsViewController: SettingsViewController)
    func settingsViewController(_ settingsViewController: SettingsViewController, didEncounter error: Error)
}

final class SettingsViewController: BaseViewController<SettingsView> {
    weak var delegate: SettingsViewControllerDelegate?
    
    fileprivate var user: User?
    
    func configure(with user: User) {
        customView.delegate = self
        customView.configure(with: user)
        
        self.user = user
    }
}

extension SettingsViewController: SettingsViewDelegate {
    func settingsView(_ settingsView: SettingsView, didChangeNameTo name: String) {
        guard let managedObjectContext = user?.managedObjectContext else {
            delegate?.settingsViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        user?.name = name
        
        managedObjectContext.save({ [unowned self] either in
            if case .right(let error) = either {
                self.delegate?.settingsViewController(self, didEncounter: error)
            }
        })
    }
    
    func settingsViewDidSelectTime(_ settingsView: SettingsView) {
        delegate?.settingsViewControllerDidSelectTime(self)
    }
    
    func settingsViewDidSelectSignificantOther(_ settingsView: SettingsView) {
        delegate?.settingsViewControllerDidSelectSignificantOther(self)
    }
    
    func settingsViewDidTapSignOut(_ settingsView: SettingsView) {
        Digits.sharedInstance().logOut()
        
        delegate?.settingsViewControllerDidTapSignOut(self)
    }
    
    func settingsView(_ settingsView: SettingsView, didEncounter error: Error) {
        delegate?.settingsViewController(self, didEncounter: error)
    }
}
