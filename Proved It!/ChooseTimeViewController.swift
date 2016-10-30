//
//  ChooseTimeViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol ChooseTimeViewControllerDelegate: class {
    func chooseTimeViewController(_ chooseTimeViewController: ChooseTimeViewController, didFinishWith user: User)
    func chooseTimeViewController(_ chooseTimeViewController: ChooseTimeViewController, didEncounter error: Error)
}

final class ChooseTimeViewController: BaseViewController<ChooseTimeView> {
    weak var delegate: ChooseTimeViewControllerDelegate?
    
    fileprivate var user: User?
    
    func configure(with user: User, isOnboarding: Bool) {
        configureCustomView(with: user)
        configureNavigationItem(isOnboarding: isOnboarding)
        
        self.user = user
    }
    
    private func configureCustomView(with user: User) {
        customView.delegate = self
        customView.configure(with: user)
    }
    
    private func configureNavigationItem(isOnboarding: Bool) {
        if isOnboarding {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        }
    }
    
    @objc private func rightBarButtonItemTapped() {
        guard let user = user else {
            delegate?.chooseTimeViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        guard let managedObjectContext = user.managedObjectContext else {
            delegate?.chooseTimeViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        managedObjectContext.save({ [unowned self] either in
            switch either {
            case .left:
                self.delegate?.chooseTimeViewController(self, didFinishWith: user)
            case .right(let error):
                self.delegate?.chooseTimeViewController(self, didEncounter: error)
            }
        })
    }
}

extension ChooseTimeViewController: ChooseTimeViewDelegate {
    func chooseTimeView(_ chooseTimeView: ChooseTimeView, didChooseTimeIntervalSinceStartOfDay timeInterval: TimeInterval) {
        guard let user = user else {
            delegate?.chooseTimeViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        guard let managedObjectContext = user.managedObjectContext else {
            delegate?.chooseTimeViewController(self, didEncounter: ApplicationError.failedToUnwrapValue)

            return
        }
        
        user.configuration = user.configuration ?? Configuration(insertedInto: managedObjectContext)
        user.configuration?.time = timeInterval
    }
    
    func chooseTimeView(_ chooseTimeView: ChooseTimeView, didEncounter error: Error) {
        delegate?.chooseTimeViewController(self, didEncounter: error)
    }
}
