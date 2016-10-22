//
//  CountdownViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol CountdownViewControllerDelegate: class {
    func countdownViewControllerDidTapProveItButton(_ countdownViewController: CountdownViewController)
    func countdownViewController(_ countdownViewController: CountdownViewController, didEncounter error: Error)
}

final class CountdownViewController: BaseViewController<CountdownView> {
    weak var delegate: CountdownViewControllerDelegate?
    
    private var user: User?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidLayoutSubviews() {
        guard let user = user else {
            return
        }
        
        customView.delegate = self
        customView.configure(with: user)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = false
    }

    @IBAction func proveItButtonTapped() {
        delegate?.countdownViewControllerDidTapProveItButton(self)
    }
    
    func configure(with user: User) {
        self.user = user
    }
}

extension CountdownViewController: CountdownViewDelegate {
    func countdownView(_ countdownView: CountdownView, didEncounter error: Error) {
        delegate?.countdownViewController(self, didEncounter: error)
    }
}
